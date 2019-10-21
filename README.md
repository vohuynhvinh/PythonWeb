# Synopsis
This is backend on **Python / [Django 2.2.6](https://docs.djangoproject.com/en/2.2/)**

# Artifacts
## Issue Tracker
https://atlassian.net

# Development
You have 2 options to run project locally:

1. Run and develop in isolated environment, using Docker (recommended)
2. Develop with full stack

## Run inside Docker

### Docker Quick Start
*(see explanations in **Run Inside Docker** section)*

```
docker-compose up -d
```

#### CLI Shortcuts
Some frequent commands have shortcuts in *Makefile*, which allow to use ```make <shrtct>```
instead of long command. See [Makefile](Makefile) content for full list of shortcuts.
Here are some of them:

* **make build** - builds Docker image for local development
* **make run** - start Docker environment, consisting of several Docker containers:
DB Server, Web Server.
* **make stop** - stop all Docker containers (DB content, temporary files,
logs, etc. will remain intact, only running processes are stopped)
* **make destroy** - delete all docker containers (DB content,
temporary files, etc. will be erased)
* **make logs** - show logs of Docker container with web server
* **make shell** - start interactive BASH shell inside Docker container
with web server, using *root* user permissions.
* **make ip** - display ip address for python-web
### Checkout project

```bash
mkdir python-web && cd python-web
git clone ssh://www.github.com/vohuynhvinh/python-web.git
```

### Prerequisites
1. Install [Docker](http://docker.io) and [Docker Compose](https://docs.docker.com/compose/).
   See [docker/README.md](docker/README.md) for tips of Docker configuration.

2. Make sure, that you have [GNU Make](https://www.gnu.org/software/make/)
    utility installed (ex. check ```make --version```)
    Install it, if needed (ex. for Ubuntu):
    ```
    sudo apt install make
    ```

### Run application with single command

Use `make` on Linux or MacOS environment

#### Start application
```
make start
```

This will sequentially execute following 'make' targets:
**install** (see description above), **build, static, run** (see descriptions below).
That is enough to get running instance of application.

Wait for missing components download and configuration process to complete
(first run may take up to 10-20 min, subsequent runs will be much faster).


Check, if containers are running:

```
docker ps
```
There should be: python-web, portgres-db,...

#### Learn your backend container IP

```
make ip
```

(*shortcut for ```docker inspect python-web | grep IPAddress```*) -
use this IP address to make HTTP requests, for example, with [Postman](http://getpostman.com) utility

#### Get shell inside Docker
You can get interactive shell inside docker container with web application

```
make shell
```
(*shortcut for ```docker-compose exec web bash```*) - this way you can execute
shell commands inside container, ex. artisan commands to manually run
DB migrations, clear/update caches for config, views, routes, etc. that
will respect paths inside Docker container and Docker's service discovery
across all docker containers, that belong to this application, and form
local environment - ex. DB server, Redis server etc.

Ex. ```ping db``` inside container will show you actual IP address of DB server.,
and ```ping redis``` will let you know redis server address.


### Local environment management
Stop, resume, destroy and recreate whole application environment

#### Stop whole environment
```
make stop
```
(*alias for ```docker-compose kill```*)
This will stop all Docker containers - DB content, temporary files,
logs, etc. will remain intact, only running processes are stopped.
You can resume application execution later, with all previously entered
accounts, content, etc.

*Use this, for example, to pause work at project and release runtime resources,
 switch to work at another project, and resume work later.*

#### Destroy whole environment
```
make destroy
```
(*alias for ```docker-compose down```*)
This will delete all docker containers - DB content, temporary files, etc.
will be erased permanently - this will free space, consumed by containers.

*Use this, if you do not plan to work with project anymore,
or you troubleshoot and need to recreate everything from scratch.*

#### Start / Resume environment
```
make run
```
(*alias for ```docker-compose up```*)
*Use this to start project after 'stop' or 'destroy'.*

This will:

* Create/Resume Web app, postgres containers (download them, if needed)
* Install composer dependencies

```
make build
```
(*alias for ```docker-compose build --no-cache web```*)
This will download required Docker images, build docker container for web application.
Inside container you will have consistent set and configuration of
PHP (with all needed modules), ...

*You may need to run this command, if server configuration was changed.
Ex. DevOps changed Nginx config, or new PHP modules were added,
or scripts, that run on container start were updated*

### Recommendations

When you switch branches, drop and recreate the whole environment,
fill it in with sample data:

```
make destroy
make run
make shell
```

This will allow you to have DB version, consistent with another branch
(another branch may require another DB structure - and additional or
missing DB migrations).


### Hosting
Note: after start docker successful

a. Check IP of web, db, api docker instances
```
make ip
make ipdb
```

b. Add IP mapping to /etc/hosts file
```
sudo vi /etc/hosts
[content]
...
# Python web
172.25.0.5  python-web.service.docker
...
[/content]
```
Note: IPs 172.25.0.5, 172.25.0.2,... get from the output above step a.

## Develop with full stack locally
**If you use Docker, see manual above**

Requirements:
* [Python](https://python.org) ^3.7
* [Django](https://www.djangoproject.com/) ^2.2.6
* [Postgresql](https://www.postgresql.org/)
* [GNU Make](https://www.gnu.org/software/make/) - build tool

Install all required software from above list, then run:

```
cd app
python main.py makemigrations
python main.py migrate
python main.py runserver 0.0.0.0:80
```

### Credentials
#### Test DB credentials
**Login**: admin@test.com

**Password**: 123456
