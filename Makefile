NAME	= ambimax/jenkins
TAG		= $(shell git rev-parse --short HEAD)
IMG		= ${NAME}:${TAG}
LATEST	= ${NAME}:latest


build: build-image tag-latest

build-image:
	@docker build --pull --cache-from "${NAME}" -t "${IMG}" .

tag-latest:
	docker tag ${IMG} ${LATEST}

start:
	docker run -d -p 127.0.0.1:8080:8080 -p 127.0.0.1:50000:50000 --name jenkins ambimax/jenkins

stop:
	docker rm -f jenkins

test:
	curl localhost:8080 | grep 'Authentication required'

official-test:
	~/official-images/test/run.sh "${IMG}"

push:
	@docker push ${NAME}

login:
	echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin

