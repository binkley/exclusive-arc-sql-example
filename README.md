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
And in another terminal, connect with `psql` or an IDE or other tool:
```
$ docker exec -it exclusive-arc-sql-example psql -U test
> -- this is an interactive PSQL session
```
When finished, either interrupt Postgres (`^C`) or shut it down with Docker:
```
docker exec -i exclusive-arc-sql-example kill -TERM 
```

### Development tip

When editing SQL files, if there are mistakes, the Docker container doesn't 
start cleanly.
Using `./run -f` in a terminal shows you the problems encountered by Postgres.

## Schema

### Data tables

- [`quotation_p`](./docker-entrypoint-initdb.d/00-schemata.sql)
- [`paragraph`](./docker-entrypoint-initdb.d/00-schemata.sql)
- [`sentence`](./docker-entrypoint-initdb.d/00-schemata.sql)
- [`word`](./docker-entrypoint-initdb.d/00-schemata.sql)

### User views

User views are _read-only_.

- [`quotation`](./docker-entrypoint-initdb.d/01-views.sql)
- [`quotation_expanded`](./docker-entrypoint-initdb.d/01-views.sql)
- [`paragraph`](./docker-entrypoint-initdb.d/01-views.sql)
- [`sentence`](./docker-entrypoint-initdb.d/01-views.sql)
- [`phrase`](./docker-entrypoint-initdb.d/01-views.sql)
- [`word`](./docker-entrypoint-initdb.d/01-views.sql)

## Expected output

```
Raw data ('quotation_p'):
 key | value | paragraph_id | sentence_id | phrase_id | word_id
-----+-------+--------------+-------------+-----------+---------
 abc |     1 |         9000 |             |           |
 def |     2 |              |         900 |           |
 ghi |     3 |              |             |        90 |
 jkl |     3 |              |             |           |       4
(4 rows)

User view ('quotation'):
 key | value | text_type | text_id
-----+-------+-----------+---------
 abc |     1 | PARAGRAPH |    9000
 def |     2 | SENTENCE  |     900
 ghi |     3 | PHRASE    |      90
 jkl |     3 | WORD      |       4
(4 rows)

User view ('quotation_expanded'):
 key | value | text_type | text_id | indentation | clauses | adverbs | length
-----+-------+-----------+---------+-------------+---------+---------+--------
 abc |     1 | PARAGRAPH |    9000 |           3 |         |         |
 def |     2 | SENTENCE  |     900 |             |       1 |         |
 ghi |     3 | PHRASE    |      90 |             |         |       2 |
 jkl |     3 | WORD      |       4 |             |         |         |     42
(4 rows)

User view ('word'):
 id |  text
----+--------
  1 | apple
  2 | pie
  3 | banana
  4 | split
  5 | carrot
  6 | cake
  7 | date
  8 | roll
(8 rows)

User view ('phrase'):
 id |     text
----+--------------
 60 | apple pie
 70 | banana split
 80 | carrot cake
 90 | date roll
(4 rows)

User view ('sentence'):
 id  |          text
-----+-------------------------
 800 | apple pie, banana split
 900 | carrot cake, date roll
(2 rows)

User view ('paragraph'):
  id  |                      text
------+-------------------------------------------------
 9000 | apple pie, banana split. carrot cake, date roll
(1 row)
```

## Discussion

There are several approaches to realizing _exclusive arcs_ in SQL.
[_Modeling Polymorphic Associations in a Relational
Database_](https://hashrocket.com/blog/posts/modeling-polymorphic-associations-in-a-relational-database#exclusive-belongs-to-aka-exclusive-arc-)
is a good discussion.
However, the focus on polymorphism makes sense for several common cases, but
while useful for technical implementation, misses the use case of exclusive arc
for "contains" or hierarchical relationships.

In the example schema, a "word" is contained in a "phrase" is contained in a 
"sentence" is contained in a "paragraph", but a "quotation" may refer to any 
of these.
One of the other design patterns might make more sense were there to be 
specialized kinds of quotations depending on the referent.
