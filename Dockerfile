FROM nextflow/nextflow:latest

COPY nf/ /tmp/

RUN chmod g+w -R /.nextflow

ENV NXF_MODE ga4gh
ENV NXF_EXECUTOR tes
ENV NXF_HOME=/tmp/.nextflow

WORKDIR /tmp

CMD ["bash", "-c", "while true; do sleep 9000h;done" ]
