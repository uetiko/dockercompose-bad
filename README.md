Simple containder for run php 5.6
==========================

# index
- Dockerfile
- docker compose
- folder organitation
- etc folder
- apache file config
- php folder config
- Shared folder objetive
- database folder
- Use this project

# Dockerfile
A `Dockerfile` is a text document that contains all the commands a user could call on the command line to assemble an image. Using `docker build` users can create an automated build that executes several command-line instructions in succession.

# docker compose
Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.
# folder organitation
# etc folder
# apache file config
# php folder config
# Shared folder objetive
# database folder
# Use this project

For build or run all containde services, write this command in your terminal
````sh
./run.sh <global_domain_name>
```

This command created all enviroment variables for use in the docker composer file,
remember chage the path of source `shared/web` for your code path and modificate
the virtualhost files config of apache, if you need.

 once you execute the run script, need enter the container source service, if you don't know the container name, in the command line put:
  docker ps
  Te container name show in the column names, remember that the container name is the global_domain_name

  for enter into the container, put in the command line:

  docker exec -it <container name> /bin/zsh

  In this cotainer, should culd run more that one project. For create a new subdomain, use the script osx-create-site.sh
  ´´´sh
  /root/osx-create-site.sh <subdomain name>
  ´´´
  This script will create a auto signed certificate openssl and enabled the virtual host for 80 and 443 port.


