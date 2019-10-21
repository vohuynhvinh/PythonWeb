FROM python:3.7.5-buster

WORKDIR /home/web/app

COPY app/dependencies.txt /home/web/app/dependencies.txt

RUN /bin/bash -c "pip install --upgrade pip &&\
     pip install --src=/src -r /home/web/app/dependencies.txt"

ADD . /home/web/app
