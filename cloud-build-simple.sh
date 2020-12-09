#!/bin/bash

# versione2 strafiga e automatica
source .env

VERSION=$(cat VERSION)
APP_NAME=${APPNAME:-credo-lingotto}

#echo Proviamo a deployare la versione $VERSION.. Nota che sto script funge solo se chiamata dalla dir giusta.

time gcloud builds submit --config cloudbuild-bifido.yaml \
    --substitutions=TAG_NAME="$VERSION",_DOCKER_VERSION="$VERSION",COMMIT_SHA="${APP_NAME}",REVISION_ID="2${APP_NAME}",REPO_NAME="3${APP_NAME}",_APPNAME="${APPNAME}"
