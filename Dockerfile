# Máquina de Uuntu con todas las herramientas necesarias para DAI

FROM ubuntu
MAINTAINER José Manuel Castillo

# Instalación de todos los paquetes
RUN apt-key --keyserver keyserver.ubuntu.com --recv 7F0CEB10
RUN echo "echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dis$
RUN apt-get update
RUN apt-get -y install python python-setuptools mongodb-10gen python-django gcc$
RUN easy_install web.py
RUN easy_install mako
RUN easy_install pymongo
RUN easy_install feedparser
RUN easy_install tweepy
