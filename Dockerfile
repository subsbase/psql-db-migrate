FROM alpine

LABEL maintainer "Ibrahimogod"

LABEL org.opencontainers.image.source="https://github.com/subsbase/psql-db-migrate"

EXPOSE 5432

ENV src_username="_" \
    src_password="_" \
    src_host="_" \
    dest_host="_" \
    dest_username="_" \
    dest_port="5432" \
    dest_password="_" \
    backup_dir="/data/backup" \
    databases="_"

#install postgres client
RUN apk --update add postgresql-client \
    && rm -rf /var/cache/apk/* 

COPY ./src /app

WORKDIR /app    

ENTRYPOINT ["sh", "db-migration-start.sh", "$src_username $src_password $src_host $dest_host $dest_username $dest_port $dest_password $backup_dir $databases"]
