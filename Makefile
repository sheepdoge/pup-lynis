build:
	docker build -t sheepdoge/pup-lynis .

test: build
	docker run sheepdoge/pup-lynis /bin/bash -c "./test.sh"

interactive: build
	docker run -it sheepdoge/pup-lynis /bin/bash
