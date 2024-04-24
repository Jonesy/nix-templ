package main

import (
	"fmt"
	"net/http"

	"github.com/a-h/templ"
	"github.com/general-metrics/nix-templ/components"
)

func main() {
	component := components.Hello("world")
	http.Handle("/", templ.Handler(component))
	fmt.Println("Listening on :3000")
	http.ListenAndServe(":3000", nil)
}
