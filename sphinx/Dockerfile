FROM ubuntu:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-sphinx \
    sphinx-intl \
    python3-sphinx-rtd-theme \
    python3-sphinxcontrib.plantuml \
    python-pip \
    python-setuptools \
    graphviz \
    ttf-dejavu \
    && pip install --upgrade pip \
    && hash -r \
    && pip install --upgrade sphinx-autobuild \
    && rm -r /var/lib/apt/lists/*
