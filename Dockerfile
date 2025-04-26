FROM busybox:glibc

ENV TARGET=1.1.1.1
ENV INTERVAL=5

COPY --from=tonistiigi/nsenter /nsenter /nsenter
COPY restart.sh /restart.sh

RUN chmod +x /restart.sh /nsenter

CMD ["/restart.sh"]
