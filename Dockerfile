FROM nextflow/nextflow:21.01.0-edge

RUN chmod g+w -R /.nextflow && \
    apk update && \
    apk add git rsync make ncurses openjdk8

COPY nf/ /tmp/nf/
COPY nextflow-fork/tests/ /tmp/nf/

RUN rm -f /tmp/nf/bin/*

COPY nextflow-bin /usr/local/bin/nextflow
COPY test.sh /usr/local/bin/nf_test

WORKDIR /mnt

CMD ["bash", "-c", "while true; do sleep 9000h;done" ]
