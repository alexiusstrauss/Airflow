import logging.config
import os

from graypy import GELFUDPHandler

GRAYLOG_HOSTNAME = "172.17.0.1"
STACK_AMBIENTE = os.getenv("STACK_AMBIENTE", "desenv")


def get_logger():
    FORMATACAO_SEFAZ = f"Airflow: {STACK_AMBIENTE} - [%(asctime)s] [%(filename)s:%(lineno)d] -  %(levelname)s - %(message)s"
    logger = logging.getLogger()
    logger.setLevel(logging.INFO)

    graylod_handler = GELFUDPHandler(GRAYLOG_HOSTNAME, 12201)
    graylod_handler.setLevel(logging.INFO)

    custom_formatter = logging.Formatter(FORMATACAO_SEFAZ)
    graylod_handler.setFormatter(custom_formatter)

    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.DEBUG)
    console_handler.setFormatter(
        logging.Formatter(
            "%(asctime)s [%(levelname)s] %(pathname)s:%(lineno)d %(message)s"
        )
    )

    logger.addHandler(graylod_handler)
    logger.addHandler(console_handler)
    return logger
