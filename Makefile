##
## Файл GNU Make для автоматизации некоторых действий при работе с проектом.
##

.DEFAULT_GOAL := build

## Корневая папка проекта.
PROJECT_DIR := $(realpath $(dir $(realpath $(lastword $(MAKEFILE_LIST)))))
## Папка для размещения собранных документов.
DOCS_DIR := $(PROJECT_DIR)/htdocs
## UID владельца папки собранных документов.
DOCS_DIR_UID ?= $(shell stat --format=%u $(DOCS_DIR))
## GID владельца папки собранных документов.
DOCS_DIR_GID ?= $(shell stat --format=%g $(DOCS_DIR))

## Папка с файлами Docker для сборки образа Sphinx.
SPHINX_DOCKER_DIR := sphinx
## Имя образа Docker со Sphinx.
SPHINX_DOCKER_IMAGE := hwd-sphinx

.PHONY: build
build: build-sphinx
	docker run --user $(DOCS_DIR_UID):$(DOCS_DIR_GID)  --rm \
		-v $(PROJECT_DIR)/src/pages:/opt/docs \
		-v $(DOCS_DIR):/opt/build \
		$(SPHINX_DOCKER_IMAGE) sphinx-build /opt/docs /opt/build

.PHONY: build-sphinx
build-sphinx:
	$(if $(shell docker images --quiet $(SPHINX_DOCKER_IMAGE)),,\
		docker build --rm --tag $(SPHINX_DOCKER_IMAGE) $(SPHINX_DOCKER_DIR))

.PHONY: dev-server
dev-server:
	docker-compose -f docker-compose.dev.yml up -d
