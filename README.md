# psql-db-migrate

this repo used to migrate your database from source to destination postgres database.

to running this app in a docker container you will need to set some enviroment variables

as below run template

`docker run --name {container name} -e "src_username={source username}" -e "src_password={source password}" -e "src_host={db host}" -e "dest_host={destination host}" -e "dest_username={destination username}" -e "dest_port={port}" -e "dest_password={your database password}" psql-migration:latest`