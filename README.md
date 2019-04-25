# Dockerfile

[![Build Status](https://travis-ci.com/arhat-dev/dockerfile.svg?branch=master)](https://travis-ci.com/arhat-dev/dockerfile)

Building blocks for [arhat-dev](https://github.com/arhat-dev)

## Rules

All builder images are based on debian

## Usage

- Method 1: build with arbitrary make target

    ```bash
    # set make target and image name
    $ export TARGET="my-app"
    $ export IMAGE_NAME="my-image-name"

    # build in your project root (with `Makefile`)
    $ docker build --build-arg TARGET=$(TARGET) \
        -t $(IMAGE_NAME) \
        -f template/without-target.dockerfile .
    ```

- Method 2: build with predefined make target

    ```bash
    # set image name
    $ export IMAGE_NAME="my-image-name"

    # build in your project root (with `Makefile`)
    $ docker build -t $(IMAGE_NAME) -f template/with-target.dockerfile
    ```