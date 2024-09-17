#!/bin/bash

# Cria as pastas necessárias
mkdir -p main/src/css main/src/js main/src/img main/assets main/docs

# Cria o arquivo index.html
echo '<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fabbrike - Soluções em Software</title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="icon" href="assets/favicon.ico">
</head>
<body>
    <header>
        <img src="img/logo.png" alt="Fabbrike Logo">
        <nav>
            <ul>
                <li><a href="#home">Home</a></li>
                <li><a href="#services">Serviços</a></li>
                <li><a href="#costs">Custos</a></li>
                <li><a href="#contact">Contato</a></li>
            </ul>
        </nav>
    </header>
    <section id="home">
        <div class="hero">
            <img src="img/hero.jpg" alt="Imagem Hero">
            <h1>Transformando Ideias em Soluções Inovadoras</h1>
            <p>Conheça como podemos ajudar sua empresa a alcançar novos patamares.</p>
            <a href="#contact" class="cta-button">Entre em Contato</a>
        </div>
    </section>
    <section id="services">
        <h2>Nossos Serviços</h2>
        <div class="service-item">
            <img src="img/services.jpg" alt="Serviço 1">
            <h3>Serviço 1</h3>
            <p>Descrição do serviço 1.</p>
        </div>
        <!-- Adicione mais serviços conforme necessário -->
    </section>
    <section id="costs">
        <h2>Custos</h2>
        <p>Descubra nossos pacotes e preços.</p>
        <!-- Adicione detalhes dos pacotes e preços -->
    </section>
    <section id="contact">
        <h2>Entre em Contato</h2>
        <form action="contact_form.php" method="post">
            <label for="name">Nome:</label>
            <input type="text" id="name" name="name" required>
            <label for="email">E-mail:</label>
            <input type="email" id="email" name="email" required>
            <label for="message">Mensagem:</label>
            <textarea id="message" name="message" required></textarea>
            <button type="submit">Enviar</button>
        </form>
        <p>Email: contato@fabbrike.com</p>
        <p>Telefone: (XX) XXXX-XXXX</p>
        <!-- Inclua o mapa se aplicável -->
    </section>
    <footer>
        <p>&copy; 2024 Fabbrike. Todos os direitos reservados.</p>
        <ul>
            <li><a href="#">Política de Privacidade</a></li>
            <li><a href="#">Termos de Serviço</a></li>
        </ul>
        <div class="social-media">
            <!-- Links para redes sociais -->
        </div>
    </footer>
    <script src="js/main.js"></script>
</body>
</html>' > main/index.html

# Cria o arquivo main.css
echo '/* Estilos principais */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
}

header {
    background-color: #333;
    color: #fff;
    padding: 10px 0;
}

nav ul {
    list-style: none;
    padding: 0;
    margin: 0;
    display: flex;
    justify-content: center;
}

nav ul li {
    margin: 0 15px;
}

nav ul li a {
    color: #fff;
    text-decoration: none;
}

.hero {
    text-align: center;
    padding: 50px 0;
    background-color: #f4f4f4;
}

.cta-button {
    background-color: #007BFF;
    color: #fff;
    padding: 10px 20px;
    text-decoration: none;
    border-radius: 5px;
}

.service-item {
    margin: 20px;
    text-align: center;
}

footer {
    background-color: #333;
    color: #fff;
    text-align: center;
    padding: 10px 0;
}

footer ul {
    list-style: none;
    padding: 0;
}

footer ul li {
    display: inline;
    margin: 0 10px;
}

footer ul li a {
    color: #fff;
    text-decoration: none;
}' > main/src/css/main.css

# Cria o arquivo responsive.css
echo '@media (max-width: 768px) {
    nav ul {
        flex-direction: column;
    }

    nav ul li {
        margin: 10px 0;
    }
}' > main/src/css/responsive.css

# Cria o arquivo main.js
echo '// JavaScript principal
document.addEventListener("DOMContentLoaded", function() {
    console.log("Página carregada e JavaScript executado.");
});' > main/src/js/main.js

# Cria o arquivo analytics.js
echo '// Código para análises (se necessário)
// Adicione seu código de análise aqui.' > main/src/js/analytics.js

# Cria arquivos de imagens e favicon (como espaços reservados)
echo '' > main/src/img/logo.png
echo '' > main/src/img/hero.jpg
echo '' > main/src/img/services.jpg
echo '' > main/src/img/contact.jpg
echo '' > main/assets/favicon.ico

# Cria o arquivo README.md
echo '# Fabbrike - Soluções em Software

Bem-vindo ao repositório da Fabbrike! Este projeto contém a estrutura para o site principal da empresa, incluindo informações sobre nossos serviços, custos e formas de contato.

## Estrutura

- `index.html`: Página principal.
- `src/css/main.css`: Estilos principais.
- `src/css/responsive.css`: Estilos responsivos.
- `src/js/main.js`: JavaScript principal.
- `src/js/analytics.js`: Scripts de análise.
- `src/img/`: Imagens usadas no site.
- `assets/`: Arquivos estáticos como favicon.
- `docs/`: Documentação adicional.

## Como Contribuir

1. Clone o repositório.
2. Faça suas alterações.
3. Envie um pull request com suas melhorias.

Obrigado por contribuir!

## Contato

Para mais informações, entre em contato conosco em contato@fabbrike.com.' > main/README.md

# Cria o arquivo server.js para Express
echo 'const express = require("express");
const path = require("path");
const { ChakraProvider } = require("@chakra-ui/react");

const app = express();
const PORT = process.env.PORT || 3000;

// Serve arquivos estáticos da pasta "main"
app.use(express.static(path.join(__dirname, "main")));

// Roteamento básico
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, "main", "index.html"));
});

// Inicializa o servidor
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});' > server.js

# Cria o arquivo package.json
echo '{
  "name": "fabbrike",
  "version": "1.0.0",
  "description": "Site principal da Fabbrike",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "@chakra-ui/react": "^2.0.0",  # Versão do Chakra UI
    "react": "^18.0.0",           # Chakra UI requer React
    "react-dom": "^18.0.0"        # Chakra UI requer ReactDOM
  },
  "author": "",
  "license": "ISC"
}' > package.json

# Mensagem de conclusão
echo "Estrutura do projeto para servidor Express com Chakra UI criada com sucesso! Execute 'npm install' para instalar as dependências e 'npm start' para iniciar o servidor."
