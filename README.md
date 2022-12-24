# psql-db-migrate

this repo used to migrate your database from source to destination postgres database.

to run this app in a docker container you will need to build image and set some enviroment variables as below run template.

at the root directory of this repo run:

`docker build . -t psql-migration:latest`

then:

`docker run --name {container name} -e "src_username={source username}" -e "src_password={source password}" -e "src_host={db host}" -e "dest_host={destination host}" -e "dest_username={destination username}" -e "dest_port={port}" -e "dest_password={your database password}" -e "databases={databases you wanna dump with comma seprated (database1,database2,..)}" psql-migration:latest`