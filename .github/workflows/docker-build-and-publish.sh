name: Docker build and publish

on: [push]

jobs:

  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v1

      - name: Login to Container Registry
        uses: docker/login-action@v1
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build and push
        id: docker_build
        uses: docker/build-push-action@v2
        with:
          push: true
          tags: '${{ github.repository }}:latest'