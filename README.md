[![Build and Push Python Image to Google Cloud Platform](https://github.com/jeantardelli/build-a-docker-image-and-push-to-gcp/actions/workflows/gcp.yml/badge.svg)](https://github.com/jeantardelli/build-a-docker-image-and-push-to-gcp/actions/workflows/gcp.yml)

# build-a-docker-image-and-push-to-gcp
This repo contains code that integrates a github actions workflow to build and push docker images to Google Cloud.

All the steps that run in GitHub actions are in the `Makefile`. For clarity it is described below too.

Note that in order to run this repo demo, it is necessary to create a IAM account in GCP with the correct permissions and with a auth key and load it as a secret actions in the repository you will be working on. More info on this on the [official Google Actions](https://github.com/google-github-actions/setup-gcloud) page.

## To build the container 

### Build image

Run the following command to build an image:

```bash
docker build --tag=${TAG_NAME} .
```

Check it was created running:

```bash
docker image ls
```

### Run image

To run the image, do the following:

```bash
docker run -it ${TAG_NAME} python app.py --name "foo"
```

And you should see the foo as output.

### To test the application

To test the app run:

```bash
pip install --upgrade pip && pip install -r requirements.txt
```

### To test the application

To test the application run:

```bash 
python -m pytest -vv -cov=app test_app.py
```

###  To lint the Dockerfile

To lint the `Dockerfile` run:

```bash 
docker run --rm -i hadolint/hadolint < Dockerfile
```

### To configure the gcloud as a Docker helper

The following command adds the Docker `credHelper` entry to Docker's configuration file, or creates the file if it doesn't exist. This will register gcloud as the credential helper for all Google-supported Docker registries. If the Docker configuration already contains a credHelper entry, it will be overwritten. 

```bash
gcloud auth configure-docker --quiet
```

See the official documentation [here](https://cloud.google.com/sdk/gcloud/reference/auth/configure-docker)

### To push the Docker image to Google Container Registry

Pushing (uploading) images is one of the most common Container Registry tasks. To do this, it is necessary to tag an image to push it later:

```bash
docker tag ${IMAGE_NAME}:latest gcr.io/${PROJECT_ID}/${IMAGE_NAME}:latest &&\
docker tag ${IMAGE_NAME}:latest gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${GIT_TAG} &&\
docker push gcr.io/${PROJECT_ID}/${IMAGE_NAME}:latest &&\
docker push gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${GIT_TAG}
```

### To push the Docker image to Google Artifact Registry

Artifact Registry is a single place for your organization to manage container images and language packages (such as Maven and npm).

```bash
docker tag ${IMAGE_NAME}:latest ${PROJECT_LOC}.pkg.dev/${PROJECT_ID}/${IMAGE_NAME}:latest &&\
docker tag ${IMAGE_NAME}:latest ${PROJECT_LOC}.pkg.dev/${PROJECT_ID}/${IMAGE_NAME}:${GIT_TAG} &&\
docker push ${PROJECT_LOC}.pkg.dev/${PROJECT_ID}/${IMAGE_NAME}:latest &&\
docker push ${PROJECT_LOC}.pkg.dev/${PROJECT_ID}/${IMAGE_NAME}:${GIT_TAG}
```
