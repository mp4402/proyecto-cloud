FROM python:3.9.12-alpine

RUN apk update && \
    apk add musl-dev libpq-dev gcc

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
WORKDIR /app/
COPY . .

CMD ["python", "application.py"]