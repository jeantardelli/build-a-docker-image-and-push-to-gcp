install-app-dependencies:
	pip install --upgrade pip &&\
	pip install -r requirements.txt

test-app:
	python -m pytest -vv -cov=app test_app.py

lint-dockerfile:
	docker run --rm -i hadolint/hadolint < Dockerfile

config-docker-client:
	gcloud auth configure-docker --quiet &&\
	gcloud auth configure-docker ${PROJECT_LOC}-docker.pkg.dev

build-docker-image:
	docker build -t ${IMAGE_NAME}:latest .

push-docker-image-to-gcr:
	docker tag ${IMAGE_NAME}:latest gcr.io/${PROJECT_ID}/${IMAGE_NAME}:latest &&\
	docker tag ${IMAGE_NAME}:latest gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${GIT_TAG} &&\
	docker push gcr.io/${PROJECT_ID}/${IMAGE_NAME}:latest &&\
	docker push gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${GIT_TAG}

push-docker-image-to-gar:
	docker tag ${IMAGE_NAME}:latest ${PROJECT_LOC}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}:latest &&\
	docker tag ${IMAGE_NAME}:latest ${PROJECT_LOC}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}:${GIT_TAG} &&\
	docker push ${PROJECT_LOC}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}:latest &&\
	docker push ${PROJECT_LOC}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}:${GIT_TAG}
