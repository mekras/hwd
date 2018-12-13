# Локальная разработка с использованием Docker

- [Системные требования и подготовка системы](https://github.com/dobrosite/site-template/wiki/requirements).

**Обратите внимание: все приведённые здесь команды должны выполняться в корневой папке проекта!**

## Краткая инструкция

Выполните команду

    make docker

После этого станут доступны:

- [http://localhost/](http://localhost/) — разрабатываемый сайт;
- [http://localhost:8080/](http://localhost:8080/) — [phpMyAdmin](https://phpmyadmin.net/);
- [http://localhost:8025/](http://localhost:8025/) — веб-интерфейс
  [mailHog](https://github.com/mailhog/MailHog).

## Данные для настройки сайта

### MySQL

Для подключения к MySQL из контейнера используйте:

- хост: `mysql`
- пользователь: `user`
- пароль: `password`
- база данных: `database`

### SMTP

Для отправки почты из контейнера используйте:

- хост SMTP: `mail`
- порт: `1025`

## Управление контейнерами

### С помощью GNU Make

Доступные команды:

- `make docker` — выполняет сборку проекта внутри контейнера Docker;
- `make docker-build` — пересобирает все контейнеры (нужно если вы меняли Dockerfile);
- `make docker-clean` — удаляет созданные Docker файлы.;
- `make docker-down` — останавливает все контейнеры;
- `make docker-exec` — выполняет заданную переменной COMMAND команду оболочки в работающем
  контейнере;
- `make docker-logs` — выводит в реальном времени журналы контейнеров;
- `make docker-pull` — обновляет используемые образы;
- `make docker-restart` — перезапускает все контейнеры;
- `make docker-run` — выполняет заданную переменной COMMAND единичную команду оболочки в контейнере;
- `make docker-shell` — запускает оболочку внутри указанного контейнера (по умолчанию в web);
- `make docker-up` — запускает все контейнеры (при первом запуске производит все необходимые настройки).

### Работа без GNU Make

Запуск контейнеров:

    env UID=$(id -u) docker-compose -f docker-compose.dev.yml up -d

Остановка контейнеров:

    docker-compose -f docker-compose.dev.yml down

## Настройки

### Переменные окружения

Значения по умолчанию указаны в файле [.env](../.env). Вы можете изменить их там, задать в окружении
или указать в качестве аргумента make.

Размещение настроек в файле `.env` позволяет использовать их как с make, так и без него.

#### DOCKER_PHP_VERSION

Используемая версия PHP. [Список доступных версий](https://hub.docker.com/r/dobrosite/php/tags/).

#### DOCKER_PHP_EXTENSIONS

Список расширений PHP через пробел. [Доступные расширения](https://github.com/dobrosite/docker-php/).

#### DOCKER_PHP_INI_SETTINGS

Разделённый пробелами список параметров php.ini, которые следует использовать.

Пример:

    PHP_INI_SETTINGS=memory_limit=-1 date.timezone=Europe/Moscow

#### DOCKER_APACHE_MODULES

Разделённый пробелами список модулей Apache, которые должны быть подключены.

#### DOCKER_MYSQL_VERSION

Версия СУБД MySQL. [Список доступных версий](https://hub.docker.com/r/dobrosite/mysql/tags/).

**Внимание!** При переходе к более старой версии MySQL желательно удалять имеющиеся файлы БД
командой `make docker-clean`, т. к. более старая версия может не работать с файлами, созданными
более новой версией MySQL. Симптомом этого является сообщение

    ERROR: Couldn't connect to Docker daemon at http+docker://localunixsocket - is it running? 

при запуске контейнеров.

#### DOCKER_SITE_PORT

Задаёт порт на котором доступен сайт.

#### DOCKER_PMA_PORT

Задаёт порт на котором доступен phpMyAdmin.

#### DOCKER_WEBMAIL_PORT

Задаёт порт на котором доступен MailHog.
