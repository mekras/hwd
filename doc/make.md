# Сборка проекта с помощью GNU Make

Некоторые используемые на этом сайте ресурсы (стили, сценарии, картинки) могут требовать предварительной сборки. Как
правило достаточно выполнить команду `make` без аргументов:

    make

Возможно для выполнения некоторых действий вам потребуются установленные в системе приложения, такие как `npm` или
`composer`. Подробнее можно прочитать в [документации к dev-tools](../develop/dev-tools/README.md).

Полный список доступных целей (команд) можно узнать выполнив команду

    make help

См. также:
 
- [Локальная разработка с использованием Docker](docker.md).

## Возможные ошибки

### Не удаётся подключиться к базе данных

База данных для сайта создаётся автоматически при первом запуске `make docker`. При этом в неё загружаются данные из
папки [db/migrations](../db/migrations/README.md). При большом объёме БД это может занять продолжительное время (до
десятков минут). Всё это время БД будет недоступна. Обычно это можно увидеть выполнив команду `make docker-logs` — она
покажет выполняемые в данный момент запросы SQL.

**Решение**

Дождитесь окончания загрузки данных. Если данные загружены, но БД всё равно недоступна, повторно выполните
`make docker` или `make docker-up`.

### Node Sass could not find a binding for your current environment

Пример сообщения об ошибке:

```
/home/user/public_html/example.com/node_modules/node-sass/lib/binding.js:15
Makefile:134: recipe for target 'styles' failed
      throw new Error(errors.missingBinary());
      ^
make[1]: выход из каталога «/home/user/public_html/example.com»
Error: Missing binding /home/user/public_html/example.com/node_modules/node-sass/vendor/linux-x64-57/binding.node
Node Sass could not find a binding for your current environment: Linux 64-bit with Node.js 8.x
/home/user/public_html/example.com/Makefile:45: recipe for target 'build' failed

Found bindings for the following environments:
  - Linux 64-bit with Node.js 9.x

This usually happens because your environment has changed since running `npm install`.
```

Такая ошибка возникает если вы сначала собрали проект внутри контейнера (например, командой `make docker`), а потом
собираете его повторно, но уже вне контейнера (например, командой `make`). Либо наоборот. Причина ошибки в несовпадении
окружений внутри и вне контейнера.

**Решение**

Удалите папку `node_modules` и соберите проект заново. 
