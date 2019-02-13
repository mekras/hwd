Классификация документации
==========================

Документацию можно разделять по разным признакам, при этом не всегда деление однозначно. Часто один
документ может сочетать в себе сразу несколько признаков. Однако уметь классифицировать документацию
крайне важно, т. к. у разных её видов есть свои особенности, которые надо учитывать.

.. contents:: Оглавление
   :local:
   :depth: 2
   :backlinks: none

.. uml::

   artifact "Документация" as root
   artifact "Внутренняя" as internal
   artifact "Внешняя" as external
   artifact "Командная" as internal_team
   artifact "Справочная" as internal_reference
   artifact "Проектная" as internal_project
   artifact "Справочная" as external_reference
   artifact "Пользовательская" as external_user
   artifact "Правила" as internal_team_rules
   artifact "Руководства" as internal_team_guides

   root --> internal
   internal --> internal_team
   internal_team --> internal_team_rules
   internal_team --> internal_team_guides
   internal --> internal_reference
   internal --> internal_project

   root --> external
   external --> external_reference
   external --> external_user

По публичности
--------------

Всю документацию, связанную с ПО, можно однозначно разделить две большие группы: *внутреннюю* —
используемую внутри команды разработки (или компании-разработчика) и *внешнюю** — предназначенную
для конечных пользователей, сторонних разработчиков и т. п.

По виду
-------

Ссылки
------

* `Building better documentation <https://ru.atlassian.com/software/confluence/documentation>`_,
  Atlassian.
