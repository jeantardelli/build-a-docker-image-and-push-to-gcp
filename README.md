# build-a-docker-image-and-push-to-gcp
This repo contains code that integrates a github actions workflow to build and push docker images to Google Cloud.

## To build the container 

### Build image

Run the following command to build an image:

```bash
docker build --tag=${TAG_NAME} .
```

Note: the `TAG_NAME` must match the `<hub-user>/<repo-name>[:<tag>]` format.

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
