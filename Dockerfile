FROM nextflow/nextflow:20.05.0-edge

COPY nf/ /tmp/

COPY shubham-nextflow/nextflow /usr/local/bin/nextflow

RUN chmod g+w -R /.nextflow && \
    apk update && \
    apk add git rsync make ncurses

ENV NXF_MODE ga4gh
ENV NXF_EXECUTOR tes
ENV NXF_HOME=/tmp/.nextflow

WORKDIR /tmp

CMD ["bash", "-c", "while true; do sleep 9000h;done" ]
