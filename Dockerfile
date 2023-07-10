FROM apache/airflow:2.6.0-python3.10

ENV TZ=America/Sao_Paulo

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    libaio1 unzip curl libsnl-dev git

# Instalação do Oracle Instant Client
ADD oracle_client/instantclient-basic-linux.x64-19.17.zip /tmp/instantclient-19.17.0.zip
RUN unzip /tmp/instantclient-19.17.0.zip -d /opt/oracle/ \
    && rm /tmp/instantclient-19.17.0.zip

RUN echo /opt/oracle/instantclient_19_17 > /etc/ld.so.conf.d/oracle-instantclient.conf \
    && ldconfig

ENV LD_LIBRARY_PATH /opt/otacle/instantclient_19_17:${LD_LIBRARY_PATH}
ENV PATH /opt/otacle/instantclient_19_17:${PATH}

USER airflow

RUN echo 'export LD_LIBRARY_PATH=/opt/oracle/instantclient_19_17' >> ~/.bashrc \
    && echo 'export PATH=/opt/oracle/instantclient_19_17:$PATH' >> ~/.bashrc

COPY pip.conf /home/airflow/.pip/pip.conf
RUN pip install --upgrade pip
RUN pip install --no-cache-dir \
    psycopg2-binary \
    pyarrow==10.0.1 \
    pandas \
    SQLAlchemy \
    apache-airflow-providers-oracle \
    django-environ \
    graypy \
    cx-Oracle==8.3.0 


COPY --chown=airflow:root dags/ /opt/airflow/dags
COPY --chown=airflow:root tests/ /opt/airflow/tests
COPY --chown=airflow:root plugins/ /opt/airflow/plugins
COPY --chown=airflow:root reports/ /opt/airflow/reports
