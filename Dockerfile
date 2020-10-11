FROM alpine:latest

RUN apk add --no-cache openssl bash

VOLUME /certs/ca
VOLUME /certs/out

COPY docker-cert-gen.sh /

CMD ["/docker-cert-gen.sh"]
