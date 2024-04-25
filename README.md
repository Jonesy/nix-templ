# nix-templ

This is an example Nix Flake project which uses [Templ](https://templ.guide/) 
templates to render HTML via a Go HTTP server.

## Getting Started

**Prerequisites** this project assumes you have [Nix flakes](https://nixos.wiki/wiki/Flakes) enabled.

For development with Templ hot-reload, run the following.

```sh
$ git clone gh repo clone Jonesy/nix-templ
$ cd nix-templ
$ nix develop
$ templ generate --watch --proxy="http://localhost:3000" --cmd="go run ."
```

Alternatively you can run precompile the templates and start the server.

```sh
$ templ generate
$ go run .
``` 

Run `$ exit` to leave the Nix shell.

## Compiling a Binary

To compile an executable of the application, run `$ nix build`. This will
compile the Go code into an executable binary installed in the Nix store, and
available locally through a symlink.

```sh
$ nix build
$ ls -la 
...
lrwxrwxrwx 1 user users 59 Apr 23 23:35 result -> /nix/store/<hash>-templ-app-0.1.0
$ ./result/bin/nix-templ
Listening on :3000
```
