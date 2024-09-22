package main

import (
    "fmt"
    "net/http"
    "my-go-app/internal/handler"
)

func main() {
    http.HandleFunc("/", handler.HomeHandler)
    http.HandleFunc("/page2", handler.Page2Handler)

    fmt.Println("Servidor rodando na porta 8000...")
    if err := http.ListenAndServe(":8000", nil); err != nil {
        fmt.Println("Erro ao iniciar o servidor:", err)
    }
}
