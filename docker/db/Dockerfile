FROM postgres:13-alpine

RUN mkdir /temp
RUN addgroup -S pggroup && adduser -S pguser -G pggroup
RUN chown -R pguser:pggroup /temp
RUN chmod 777 /temp

USER pguser
