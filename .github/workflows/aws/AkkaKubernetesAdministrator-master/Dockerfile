FROM ubuntu:18.04
MAINTAINER Miguel Lemos <miguelemosreverte@gmail.com>

RUN apt-get update && apt-get install -y curl


RUN apt-get update -y && \
    apt-get install -y python-pip python-dev

COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip install -r requirements.txt

COPY . /app
RUN bash -c "./init.sh"

ENTRYPOINT [ "python" ]

CMD [ "app.py" ]