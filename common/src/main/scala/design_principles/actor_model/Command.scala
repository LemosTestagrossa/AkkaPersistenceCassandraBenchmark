package design_principles.actor_model

import akka.entity.ShardedEntity.Sharded

trait Command extends Sharded {
  def aggregateRoot: String

  override def entityId: String = aggregateRoot

  override def shardedId: String = entityId
}
