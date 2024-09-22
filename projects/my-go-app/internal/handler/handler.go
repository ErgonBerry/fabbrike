package handler

import (
    "net/http"
    "path/filepath"
)

func HomeHandler(w http.ResponseWriter, r *http.Request) {
    // Definir o caminho do arquivo HTML
    path := filepath.Join("web", "index.html")
    // Servir o arquivo HTML
    http.ServeFile(w, r, path)
}

func Page2Handler(w http.ResponseWriter, r *http.Request) {
    // Definir o caminho do arquivo HTML
    path := filepath.Join("web", "page2.html")
    // Servir o arquivo HTML
    http.ServeFile(w, r, path)
}
