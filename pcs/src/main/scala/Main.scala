import akka.actor.{ActorSystem, Props}
import akka.cluster.Cluster
import akka.entity.ShardedEntity
import akka.entity.ShardedEntity.ShardedEntityRequirements
import akka.management.cluster.bootstrap.ClusterBootstrap
import akka.management.scaladsl.AkkaManagement
import akka.persistence.PersistentActor
import akka.stream.{ActorMaterializer, Materializer}
import akka.stream.scaladsl.Source
import com.typesafe.config.ConfigFactory
import design_principles.actor_model.{Command, Event}
import monitoring.{Counter, KamonMonitoring, Monitoring}
import serialization.EventSerializer

import scala.concurrent.Await
import scala.concurrent.duration.Duration

object Main extends App {

  implicit val system = Generators.actorSystem()
  AkkaManagement(system).start()
  val cluster = ClusterBootstrap(system).start()

  object PersistentActorExample {
    object PersistentActorExampleProtocol {
      case class Hi(aggregateRoot: String, message: String = "hello!") extends Command
      case class SaidHi(hello: Hi) extends Event
    }

    class PersistentActorExampleActor(monitoring: Monitoring) extends PersistentActor {

      private final var lastHi: Option[PersistentActorExampleProtocol.Hi] = None

      private final val PersistentActorExampleActorTotalPersistences: Counter =
        monitoring.counter("PersistentActorExampleActorTotalPersistences")

      override def receiveRecover: Receive = {
        case saidHi: PersistentActorExampleProtocol.SaidHi =>
          lastHi = Some(saidHi.hello)
      }

      override def receiveCommand: Receive = {
        case hi: PersistentActorExampleProtocol.Hi =>
          persistAsync(PersistentActorExampleProtocol.SaidHi(hi)) { _ =>
            lastHi = Some(hi)
            PersistentActorExampleActorTotalPersistences.increment()
            println(lastHi)
            sender() ! akka.Done
          }
      }

      override def persistenceId: String = this.self.path.name
    }
    object PersistentActorExampleActor extends ShardedEntity[Monitoring] {
      override def props(monitoring: Monitoring): Props =
        Props(
          new PersistentActorExampleActor(monitoring)
        )
    }
  }

  implicit val shardedEntityRequirements: ShardedEntityRequirements =
    ShardedEntityRequirements(system)
  val monitoring = new KamonMonitoring
  val PersistentActorExampleActorRef =
    PersistentActorExample.PersistentActorExampleActor
      .startWithRequirements(monitoring)

  import scala.concurrent.duration._
  Cluster.get(system).registerOnMemberUp {
    val million = 1000 * 1000
    val `11K TPS` = 11 * 1000
    Source
      .fromIterator(() => (1 to million).iterator)
      .throttle(`11K TPS`, 1 second)
      .mapAsync(1) { index =>
        PersistentActorExampleActorRef.ask[akka.Done](
          PersistentActorExample.PersistentActorExampleProtocol
            .Hi(index.toString)
        )
      }
      .run()
  }

  Await.result(system.whenTerminated, Duration.Inf)
}
