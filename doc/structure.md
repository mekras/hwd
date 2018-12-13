# Структура проекта

- [db](../db/README.md) — Папка предназначена для сохранения в VCS файлов, относящихся к БД сайта.
  - [migrations](../db/migrations/README.md) — Миграции БД.
- [develop](../develop/README.md) — Инструменты разработки.
  - [dev-tools](https://github.com/dobrosite/dev-tools#readme) — Инструменты для разработки сайтов.
  - [patch](../develop/patch/README.md) — Изменения в коде CMS и её расширений.
  - `docker.mk` — Цели [GNU Make](https://www.gnu.org/software/make/manual/make.html) для работы с Docker.
  - `vhost.conf` — Виртуальный хост Apache HTTPD для локальной разработки.
- `doc` — Папка для документации по сайту.
- [docker](../docker/README.md) — Папка для хранения файлов контейнеров Docker.
- `htdocs` — Папка для размещения файлов сайта.
- `.env` — Настройки окружения для Docker.
- `docker-compose.dev.yml` — Настройки Docker для локальной разработки.
- `docker-compose.test.yml` — Настройки Docker для тестовой площадки.
- `docker-compose.yml` — Настройки Docker для имитации боевого сайта.
- `init.mk` — Файл GNU Make для подготовки шаблона к использованию (после будет удалён).
- `Makefile` — Заготовка файла GNU Make для автоматизации работы с сайтом.
- `README.template.md` — Заготовка README.md (будет автоматически переименована при подготовке шаблона). 
