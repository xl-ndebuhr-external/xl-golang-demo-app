FROM debian:10-slim

COPY ./wiki /opt/wiki
COPY ./data /opt/data
COPY ./tmpl /opt/tmpl
COPY ./static /opt/static

WORKDIR /opt/
ENTRYPOINT /opt/wiki