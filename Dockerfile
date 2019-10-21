FROM python:3.7.5-buster

WORKDIR /home/api/app

COPY app/dependencies.txt /home/api/app/dependencies.txt

RUN /bin/bash -c "pip install --upgrade pip &&\
     pip install --src=/src -r /home/api/app/dependencies.txt"

ADD . /home/api/app
