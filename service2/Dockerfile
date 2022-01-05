FROM python:alpine3.6

RUN apk --no-cache add curl='7.61.1-r2' \
    && curl -sL https://github.com/openfaas/faas/releases/download/0.9.14/fwatchdog > /usr/bin/fwatchdog \
    && chmod +x /usr/bin/fwatchdog

ENV fprocess="python entrypoint.py"
COPY entrypoint.py /

RUN pip install with --no-cache-dir requests=='2.26.0'

EXPOSE 8080
CMD [ "fwatchdog" ]