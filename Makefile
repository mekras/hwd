##
## Файл GNU Make для автоматизации некоторых действий при работе с проектом.
##

.DEFAULT_GOAL := all

## Корневая папка проекта.
PROJECT_DIR := $(realpath $(dir $(realpath $(lastword $(MAKEFILE_LIST)))))

## Папка исходных файлов.
SOURCE_DIR := $(PROJECT_DIR)/src

## Папка для размещения собранных документов.
TARGET_DIR := $(PROJECT_DIR)/htdocs
## UID владельца папки собранных документов.
TARGET_DIR_UID ?= $(shell stat --format=%u $(TARGET_DIR))
## GID владельца папки собранных документов.
TARGET_DIR_GID ?= $(shell stat --format=%g $(TARGET_DIR))

## Основное имя для скачиваемых документов.
DOC_BASENAME := write-docs

## Образ Docker со Sphinx.
SPHINX_DOCKER_IMAGE := mekras/sphinx-doc:latest

## Папка внутри контейнера, куда монтировать папку src.
DOCKER_SRC_DIR := /docs
## Папка внутри контейнера, куда монтировать папку htdocs.
DOCKER_DST_DIR := /opt/build

## Выполняет единичную команду оболочки в контейнере.
##
## @param $(1) Команда, которую надо выполнить.
## @param $(2) Дополнительные опции для docker.
##
docker-run = docker run --user $(TARGET_DIR_UID):$(TARGET_DIR_GID) --rm \
	-v $(PROJECT_DIR)/src:$(DOCKER_SRC_DIR) $(2) \
	$(SPHINX_DOCKER_IMAGE) $(1)

.PHONY: all
all: clean $(TARGET_DIR)/yandex_b294e47024dde966.html | html pdf ## Собирает все конечные файлы.

.PHONY: clean ## Очищает все результаты сборки.
clean:
	find $(TARGET_DIR) -depth -mindepth 1 ! -name .gitignore ! -name robots.txt -delete

.PHONY: start-server
start-server: ## Запускает сервер разработки.
	docker-compose -f docker-compose.dev.yml up

.PHONY: html
html: | clean ## Собирает документацию в HTML.
	$(call docker-run,make html,-v $(TARGET_DIR):$(DOCKER_DST_DIR))
	mv -f $(TARGET_DIR)/html/* $(TARGET_DIR)/
	-rm -rf $(TARGET_DIR)/doctrees $(TARGET_DIR)/html

.PHONY:
pdf: $(TARGET_DIR)/$(DOC_BASENAME).pdf ## Создаёт документ PDF.

$(TARGET_DIR)/$(DOC_BASENAME).pdf:
	$(call docker-run,make latexpdf,-v $(TARGET_DIR):$(DOCKER_DST_DIR))
	mv $(TARGET_DIR)/latex/$(DOC_BASENAME).pdf $(TARGET_DIR)/
	-rm -rf $(TARGET_DIR)/doctrees $(TARGET_DIR)/latex

$(TARGET_DIR)/yandex_%.html: $(SOURCE_DIR)/other/yandex_%.html
	cp $< $@
