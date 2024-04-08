ARG PYTHON_VERSION
FROM python:${PYTHON_VERSION}

WORKDIR /usr/src/app

COPY ./myapp /usr/src/app

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "app.py"]
