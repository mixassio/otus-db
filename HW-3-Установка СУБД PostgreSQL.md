```
➜  ~ psql --host=localhost --port=5432 --username=postgres --password
Password:
psql (15.2, server 15.1 (Debian 15.1-1.pgdg110+1))
Type "help" for help.

postgres=# select * from cross_category_params;
 fk_category_id | fk_category_param_id
----------------+----------------------
(0 rows)

postgres=#
```