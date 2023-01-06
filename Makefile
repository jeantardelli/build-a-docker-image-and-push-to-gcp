install-app-dependencies:
	pip install --upgrade pip &&\
	pip install -r requirements.txt

test-app:
	python -m pytest -vv -cov=app test_app.py

lint-dockerfile:
	docker run --rm -i hadolint/hadolint < Dockerfile

config-docker-client:
	gcloud auth configure-docker --quiet

build-docker-image:
	docker build -t ${IMAGE_NAME}:latest .

push-docker-image-to-gcr:
	docker tag ${IMAGE_NAME}:latest gcr.io/${PROJECT_ID}/${IMAGE_NAME}:latest &&\
	docker tag ${IMAGE_NAME}:latest gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${GIT_TAG} &&\
	docker push gcr.io/${PROJECT_ID}/${IMAGE_NAME}:latest &&\
	docker push gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${GIT_TAG}
