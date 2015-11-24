FROM ubuntu:14.04
MAINTAINER datateam@freshbooks.com

ENV TERM linux
ENV INITRD No

ENV AIRFLOW_HOME /usr/local/airflow
ENV C_FORCE_ROOT true
ENV PYTHONLIBPATH /usr/lib/python2.7/dist-packages

RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends \
    netcat \
    python-pip \
    python-dev \
    libmysqlclient-dev \
    libkrb5-dev \
    libsasl2-dev \
    libssl-dev \
    libffi-dev \
    libpq-dev \
    build-essential \
    && mkdir -p $AIRFLOW_HOME/logs \
    && mkdir $AIRFLOW_HOME/dags \
    && apt-get clean \
    && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /usr/share/man \
    /usr/share/doc \
    /usr/share/doc-base

ADD requirements.txt requirements.txt
RUN pip install -r requirements.txt
ADD entrypoint.sh /root/entrypoint.sh

EXPOSE 8080
EXPOSE 5555
EXPOSE 8793

ENTRYPOINT ["/root/entrypoint.sh"]
