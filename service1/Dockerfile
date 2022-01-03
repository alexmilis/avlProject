FROM frolvlad/alpine-python2

RUN apk --no-cache add curl \
    && curl -sL "https://github.com/openfaas/faas/releases/download/0.9.14/fwatchdog" > /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

ENV fprocess="python2 entrypoint.py"
COPY entrypoint.py /

EXPOSE 8080
CMD [ "/usr/bin/fwatchdog" ]
