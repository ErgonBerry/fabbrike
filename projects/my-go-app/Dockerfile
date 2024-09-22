# Usar a imagem oficial do Go
FROM golang:1.21-alpine

# Definir o diretório de trabalho no contêiner
WORKDIR /app

# Copiar o go.mod e go.sum para o contêiner
COPY go.mod ./ 

# Baixar as dependências Go
RUN go mod download

# Copiar o restante dos arquivos da aplicação
COPY . .

# Compilar o código Go
RUN go build -o app ./cmd/app

# Expor a porta 8000
EXPOSE 8000

# Comando para rodar o binário
CMD ["./app"]
