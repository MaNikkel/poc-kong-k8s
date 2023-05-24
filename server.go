package main

import (
	"net/http"
)

func main() {
	http.HandleFunc("/webhook", Webhook)

	http.ListenAndServe(":80", nil)
}

func Webhook(w http.ResponseWriter, r *http.Request) {

	w.Write([]byte("<h1>Hello from webhook!</h1>"))
}
