FROM busybox:glibc

ENV TARGET=8.8.8.8
ENV INTERVAL=5

COPY --from=alexeiled/nsenter /nsenter /nsenter
COPY restart.sh /restart.sh

RUN chmod +x /restart.sh /nsenter

CMD ["/restart.sh"]
