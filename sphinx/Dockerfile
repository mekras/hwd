FROM ubuntu:latest

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    graphviz \
    lmodern \
    luatex \
    python-pip \
    python-setuptools \
    python3-sphinx \
    python3-sphinx-rtd-theme \
    python3-sphinxcontrib.plantuml \
    sphinx-intl \
    tex-common \
    texlive \
    texlive-binaries \
    texlive-extra-utils \
    texlive-fonts-extra \
    texlive-full \
    texlive-lang-cyrillic \
    texlive-latex-base \
    texlive-latex-base-doc \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-luatex \
    texlive-pstricks \
    texlive-science \
    texlive-xetex \
    ttf-dejavu \
    && pip install --upgrade pip \
    && hash -r \
    && pip install --upgrade sphinx-autobuild \
    && rm -r /var/lib/apt/lists/*
