#+++++++++++++++++++++++++++++++++++++++
# Dockerfile for webdevops/sphinx:latest
#    -- automatically generated  --
#+++++++++++++++++++++++++++++++++++++++

FROM webdevops/bootstrap:alpine

RUN set -x \
    && apk-install \
    python \
    py-crypto \
    py2-pip \
    py-pillow \
    py-yaml \
    py-sphinx \
    py-sphinx_rtd_theme \
    graphviz \
    ttf-dejavu \
    && pip install --upgrade pip \
    && hash -r \
    && pip install --upgrade sphinxcontrib-googlechart \
    && pip install --upgrade sphinxcontrib-googlemaps \
    && pip install --upgrade sphinxcontrib-httpdomain \
    && pip install --upgrade sphinxcontrib-slide \
    && pip install --upgrade sphinx-autobuild \
    && pip install --upgrade recommonmark \
    && pip install t3SphinxThemeRtd \
    && pip install t3fieldlisttable \
    && pip install t3tablerows \
    && pip install t3targets \
    && docker-run-bootstrap \
    && docker-image-cleanup
