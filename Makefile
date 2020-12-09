
VERSION = $(shell cat VERSION)
PWD = $(shell pwd)
APPNAME = lingotto
PROJECT_ID = metarepo
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

docker-run-p48000: docker-build
	docker run -p 48000:8080 -it $(APPNAME):v$(VERSION)

#docker-push: docker-build
docker-push: 
	docker tag $(APPNAME):v$(VERSION) gcr.io/$(PROJECT_ID)/$(APPNAME):v$(VERSION) 
	docker push gcr.io/$(PROJECT_ID)/$(APPNAME):v$(VERSION) 
	#yellow Se credi che sta versione sia strafiga, fai anche cio che segue:
	docker tag $(APPNAME):v$(VERSION) $(APPNAME)
	docker tag $(APPNAME) gcr.io/$(PROJECT_ID)/$(APPNAME)
	docker push gcr.io/$(PROJECT_ID)/$(APPNAME)

autotag:
	git tag v$(VERSION) master
	git push --tags