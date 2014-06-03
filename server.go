package main

import (
	"fmt"
	"net/http"
)

type MyHandler struct {
}

func (handler MyHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	w.Header().Add("X-Written-By", "Matt")
	fmt.Fprintf(w, "{\"status\":\"ok\"}")
}

func main() {

	done := make(chan bool)
	address := "127.0.0.1:8080"

	go func() {
		http.ListenAndServe(address, MyHandler{})
		done <- true
	}()

	fmt.Println("Listening on", address)
	<-done

}
