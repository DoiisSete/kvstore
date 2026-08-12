# kvstore

A lightweight HTTP key-value store built as an Erlang/OTP application, using [Cowboy](https://github.com/ninenines/cowboy) as the HTTP server.

## Requirements

- Erlang/OTP
- [rebar3](https://rebar3.org)

## Build

```sh
$ rebar3 compile
```

## Run

```sh
$ rebar3 shell
```

## API

| Method   | Endpoint      | Description             |
|----------|---------------|-------------------------|
| `GET`    | `/`           | Health check            |
| `GET`    | `/key/:key`   | Retrieve a value by key |
| `PUT`    | `/key/:key`   | Store a value by key    |
| `DELETE` | `/key/:key`   | Delete a value by key   |

### Examples

```sh
# Store a value
curl -X PUT http://localhost:8080/key/hello -d "world"

# Retrieve a value
curl http://localhost:8080/key/hello
# hello: world

# Delete a value
curl -X DELETE http://localhost:8080/key/hello
```

## Dependencies

- [cowboy](https://github.com/ninenines/cowboy) — HTTP server
- [ranch](https://github.com/ninenines/ranch) — TCP acceptor pool
- [cowlib](https://github.com/ninenines/cowlib) — Cowboy support library
