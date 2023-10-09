<a href="./LICENSE.md">
<img src="./images/public-domain.svg" alt="Public Domain"
align="right" width="20%" height="auto"/>
</a>

# Demonstrating the "exclusive arc" pattern in SQL

[![build](https://github.com/binkley/exclusive-arc-sql-example/workflows/build/badge.svg)](https://github.com/binkley/exclusive-arc-sql-example/actions)
[![issues](https://img.shields.io/github/issues/binkley/exclusive-arc-sql-example.svg)](https://github.com/binkley/exclusive-arc-sql-example/issues/)
[![pull requests](https://img.shields.io/github/issues-pr/binkley/exclusive-arc-sql-example.svg)](https://github.com/binkley/exclusive-arc-sql-example/pulls)
[![license](https://img.shields.io/badge/license-Public%20Domain-blue.svg)](http://unlicense.org/)

An example of SQL [schemata](./docker-entrypoint-initdb.d/00-schemata.sql),
[views](./docker-entrypoint-initdb.d/01-views.sql)
[functions](./docker-entrypoint-initdb.d/02-funcs.sql), and
[data](./docker-entrypoint-initdb.d/03-data.sql) for exclusive arc.

Try it:

```
$ ./run  # Run the examples
$ ./run -h
Usage: run [-f]

Starts Postgres in the background, runs examples, and shuts Postgres down.

Options:
   -f   starts Postgres in the foreground; does not run examples; INT to quit
   -h   prints this help and exits
```

The only dependencies of this project are Bash and Docker.

## Exploring

To explore the schema and data, start Postgres in _foreground_ mode:
```
$ ./run -f
```
And in another terminal, connect with `psql`:
```
$ docker exec -it exclusive-arc-sql-example psql -U test
> -- this is an interactive PSQL session
```
When finished, either interrupt Postgres (`^C`) or shut it down with Docker:
```
docker exec -i exclusive-arc-sql-example kill -TERM 
```

## Schema

### Data tables

- [`quotation_p`](./docker-entrypoint-initdb.d/00-schemata.sql)
- [`paragraph`](./docker-entrypoint-initdb.d/00-schemata.sql)
- [`sentence`](./docker-entrypoint-initdb.d/00-schemata.sql)
- [`word`](./docker-entrypoint-initdb.d/00-schemata.sql)

### User views

-[`quotation`](./docker-entrypoint-initdb.d/01-views.sql)

## Expected output

```
Raw data ('quotation_p'):
 key | value | paragraph_id | sentence_id | word_id 
-----+-------+--------------+-------------+---------
 abc |     1 |            1 |             |        
 def |     2 |              |           1 |        
 ghi |     3 |              |             |       1
(3 rows)

User view ('quotation'):
 key | value | text_type | text_id 
-----+-------+-----------+---------
 abc |     1 | PARAGRAPH |       1
 def |     2 | SENTENCE  |       1
 ghi |     3 | WORD      |       1
(3 rows)
```

## Reading
