FROM debian:10-slim

COPY ./wiki /opt/wiki
COPY ./data /opt/data
COPY ./tmpl /opt/tmpl
COPY ./static /opt/static

ENTRYPOINT ["cd", "/opt/", "&&", "/opt/wiki"]
CMD [""]