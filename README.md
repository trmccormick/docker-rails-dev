# docker-rails-dev
Test Enviroment for Vagrant / Docker / Mysql / Rails

## Running
Use ("vagrant up --no-parallel") to launch. You can get errors when if you do not start this way. 

## Mysql Database 
To setup the database cd into the docker-host-vm and do a vagrant ssh. Once inside the host run the following.
docker exec -t myapp rails db:create
docker exec -t myapp rails db:migrate

If you have seed database run
docker exec -t myapp rails db:seed

## Errors, queries and bugs

## References
1. [Running a Rails Development Environment in Docker](https://blog.codeship.com/running-rails-development-environment-docker/)
