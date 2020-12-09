
VERSION = $(shell cat VERSION)
PWD = $(shell pwd)
APPNAME = lingotto
#PROJECT_ID = metarepo
#CLOUD_RUN_OPTIONS = --platform managed  --region europe-west1 --allow-unauthenticated  --set-env-vars PROVA=comune-a-dev-e-prod,FOO_COMMON=DEV_O_PROD --memory 2Gi 

#common-pre-run:

install:
	echo on Ubuntu:
	sudo apt-get install postgresql-client libpq5 libpq-dev
	bundle install

run:
	bundle exec rails s

cloud-build-local:
	 time gcloud builds submit --config cloudbuild-trigger.yaml

docker-build:
	docker build -t $(APPNAME):v$(VERSION) .

docker-run-p3000: docker-build
	docker run -p 3000:8080 -it $(APPNAME):v$(VERSION)