##
## Файл GNU Make для автоматизации некоторых действий при работе с проектом.
##
## Выполните команду "make help" чтобы увидеть список доступных целей (действий).
##

# Подключаем локальные настройки сборки, если они есть.
ifneq ($(realpath Makefile.local),)
include Makefile.local
endif

# Подключаем нужные библиотеки, если dev-tools установлены.
ifneq ($(realpath develop/dev-tools/make),)
include develop/dev-tools/make/common.mk
include develop/dev-tools/make/npm.mk

## Папка с composer.json (htdocs)
COMPOSER_ROOT_DIR := $(PUBLIC_DIR)
include develop/dev-tools/make/composer.mk
include develop/dev-tools/make/remote.mk
include develop/dev-tools/make/db.mk
#include develop/dev-tools/make/wordpress.mk
endif

# Эта часть нужна только для начальной подготовки шаблона, после чего её можно удалить.
ifneq ($(realpath init.mk),)
include init.mk
endif


## Папка клиентских ресурсов.
assets_dir=$(PUBLIC_DIR)

.PHONY: build
##
## Цель должна быть написана таким образом, чтобы:
## а) после выполнения make без аргументов на чистом проекте, сайт был полностью готов к работе;
## б) выполнялись только необходимые действия (чтобы сборка занимала как можно меньше времени).
##
build: prepare ## Собирает изменившиеся файлы (цель по умолчанию).
# Каждая цель должна выполняться в отдельном процессе, чтобы после выполнения prepare Makefile был
# перечитан заново для подключения установленных библиотек.
#	$(MAKE) scripts styles

## Подключаем цели Docker.
# Делаем это после цели build, чтобы, если dev-tools не установлены, именно build была целью по
# умолчанию.
include develop/docker.mk

.PHONY: prepare
prepare: develop/dev-tools/.git ## Готовит проект и окружение к сборке.
	$(MAKE) deps

## Устанавливает dev-tools.
develop/dev-tools/.git:
	git submodule init
	git submodule update
	cd develop/dev-tools && git checkout latest-1.x

.PHONY: deps
deps: ## Устанавлдивает сторонние зависимости.
# Если есть файл composer.json, устанавливаем зависимости через Composer.
ifneq ($(realpath $(composer.json)),)
	$(MAKE) $(COMPOSER_VENDOR_DIR)
endif
# Если есть файл package.json, устанавливает зависимости через npm.
ifneq ($(realpath $(package.json)),)
	$(MAKE) node_modules
endif

.PHONY: update
update: ## Обновляет зависимости проекта.
# Если есть файл composer.json, обновляем зависимости через Composer.
ifneq ($(realpath $(composer.json)),)
	$(MAKE) composer-update
endif
# Если есть файл package.json, обновляем зависимости через npm.
ifneq ($(realpath $(package.json)),)
	$(MAKE) npm-update
endif

.PHONY: clean
clean: ## Очищает проект от артефактов сборки.
	$(MAKE) docker-clean
	$(MAKE) npm-clean
	$(MAKE) composer-clean

#.PHONY: scripts
#scripts: $(uglifyjs) ## Собирает сценарии.
#	$(call run-uglifyjs,$(assets_dir)/bundle.js,$(assets_dir)/bundle.min.js)
#
#.PHONY: styles
#styles: $(sass) ## Собирает стили.
#	$(call run-sass,$(assets_dir)/bundle.scss,$(assets_dir))
