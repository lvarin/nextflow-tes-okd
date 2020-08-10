FROM nextflow/nextflow:20.05.0-edge

RUN chmod g+w -R /.nextflow && \
    apk update && \
    apk add git rsync make ncurses

COPY nf/ /tmp/nf/
COPY nextflow-fork/tests/ /tmp/nf/

COPY nextflow-fork/build/releases/nextflow-20.07.1-all /usr/local/bin/nextflow
COPY test.sh /usr/local/bin/nf_test

ENV NXF_MODE ga4gh
ENV NXF_EXECUTOR tes
ENV NXF_HOME=/tmp/.nextflow

WORKDIR /mnt

CMD ["bash", "-c", "while true; do sleep 9000h;done" ]
