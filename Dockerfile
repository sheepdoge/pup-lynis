FROM ubuntu:16.04

RUN apt-get update -qq && \
  apt-get -y install \
  apt-transport-https \
  build-essential \
  git \
  python \
  python-pip \
  vim

RUN pip install --upgrade pip
RUN pip install "ansible>=2.0,<3.0"

RUN mkdir /sheepdoge-test

WORKDIR /sheepdoge-test

ADD tasks ./tasks
ADD templates ./templates
ADD vars ./vars
ADD tests/* ./

RUN chmod u+x test.sh
