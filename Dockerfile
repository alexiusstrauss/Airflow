FROM apache/airflow:2.7.2-python3.10

ENV TZ=America/Sao_Paulo

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    libaio1 unzip curl libsnl-dev nano

USER airflow

ADD pip.conf /home/airflow/.pip/pip.conf
RUN pip install --upgrade pip 
RUN pip install --no-cache-dir \
    psycopg2-binary \
    ipython==8.15.0 \
    pyarrow==10.0.1 \
    pyocclient==0.6 \
    pandas==1.4.3 \
    numpy==1.23.3 \
    SQLAlchemy==2.0.21 \
    django-environ==0.11.2 \
    graypy \
    black==23.9.1 \
    xlwt \
    openpyxl \
    tqdm

COPY --chown=airflow:root dags/ /opt/airflow/dags
COPY --chown=airflow:root tests/ /opt/airflow/tests
COPY --chown=airflow:root plugins/ /opt/airflow/plugins
COPY --chown=airflow:root reports/ /opt/airflow/reports


