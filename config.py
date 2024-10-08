import os
from dotenv import load_dotenv
import logging


def log_success(message: str):
    """Log a success message."""
    logging.info(f'SUCCESS: {message}')


def log_error(message: str):
    """Log an error message."""
    logging.error(f'ERROR: {message}')


def log_info(message: str):
    """Log an informational message."""
    logging.info(f'INFO: {message}')


def log_warning(message: str):
    """Log a warning message."""
    logging.warning(f'WARNING: {message}')


logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

load_dotenv('.env')
logging.info('Loading environment variables from .env file.')

DEBUG = os.getenv('DEBUG')
SECRET = os.getenv('SECRET')
PROTOCOL = os.getenv('PROTOCOL')
HOST = os.getenv('HOST')
PORT = int(os.getenv('PORT'))
BASE_API = os.getenv('BASE_API')
USERNAME = os.getenv('USERNAME')
PASSWORD = os.getenv('PASSWORD')
NAME = os.getenv('NAME')

log_success('Environment variables loaded successfully.')
