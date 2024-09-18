# Etapa 1: Builder
FROM node:18-alpine AS builder

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Copiar os arquivos package.json e package-lock.json para instalar as dependências
COPY package*.json ./

# Instalar as dependências
RUN npm install
RUN npm install -g nodemon@3.1.5

# Copiar todos os arquivos da aplicação
COPY . .

# Compilar o TypeScript (gera a saída em dist/)
RUN npm run build

# Etapa 2: Produção
FROM node:18-alpine AS production

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Copiar somente os arquivos necessários da etapa anterior
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/public ./public

# Instalar somente as dependências de produção
RUN npm install

# Instalar nodemon para desenvolvimento
RUN npm install -g nodemon@3.1.5

# Expor a porta da aplicação
EXPOSE 3000

# Variáveis de ambiente
ENV NODE_ENV=production

# Comando para iniciar a aplicação
CMD ["node", "dist/index.js"]
