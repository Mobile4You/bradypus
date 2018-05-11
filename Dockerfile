FROM crystallang/crystal:0.24.2 AS builder

RUN apt-get -y update \
  && apt-get -y install libsqlite3-dev\
  && apt-get -y clean all

RUN mkdir /app
WORKDIR /app

COPY . /app

RUN shards build


FROM crystallang/crystal:0.24.2

RUN mkdir /app
COPY --from=builder /app/bin/bradypus /app/bradypus

ENV AMBER_ENV ""
ENV DATABASE_URL ""
ENV REDIS_URL ""

CMD ["/app/bradypus"]
