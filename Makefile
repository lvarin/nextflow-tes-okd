version ?= $(shell date +%Y%m%d-%H%M)
image_name=lvarin/nextflow-tes-okd

all: build_image deploy_image

clean:
	rm nextflow-bin
	rm -rf nextflow-fork/build/releases/

build: build_image

build_image: nextflow-bin
	docker build -t ${image_name}:${version} .

nextflow-bin: nextflow-fork/build/releases/
	cp $(shell find nextflow-fork/build/releases/ -type f) nextflow-bin

nextflow-fork/build/releases/: nexflow-fork/Makefile
	cd nextflow-fork && make && make packGA4GH

nexflow-fork/Makefile:
	git submodule update --init --recursive


deploy_image:
	docker push ${image_name}:${version}
