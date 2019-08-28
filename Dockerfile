FROM debian:10-slim

COPY ./wiki /opt/wiki
COPY ./data /opt/data
COPY ./tmpl /opt/tmpl
COPY ./static /opt/static

COPY ./entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD [""]