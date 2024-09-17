#!/bin/bash

# Nome do projeto
PROJECT_NAME="my-app"

# Cria o diretório do projeto e entra nele
mkdir $PROJECT_NAME
cd $PROJECT_NAME

# Inicializa um repositório Git
git init

# Inicializa o npm e cria package.json
npm init -y

# Instala pacotes necessários
npm install express mongoose dotenv

# Instala pacotes de desenvolvimento
npm install typescript @types/node @types/express nodemon ts-node --save-dev

# Configura TypeScript
npx tsc --init

# Ajusta o tsconfig.json
sed -i 's/"outDir": ".\/",/"outDir": ".\/dist",/' tsconfig.json
sed -i 's/\/\/ "rootDir": ".\/",/"rootDir": ".\/src",/' tsconfig.json
sed -i 's/\/\/ "esModuleInterop": false,/"esModuleInterop": true,/' tsconfig.json

# Cria a estrutura de diretórios
mkdir -p src/{controllers,models,routes,views}
mkdir public
mkdir public/css

# Cria o arquivo .env
echo "MONGO_URI=mongodb://localhost:27017/questionnaireDB" > .env

# Cria o arquivo .gitignore
echo "node_modules" > .gitignore
echo ".env" >> .gitignore
echo "dist" >> .gitignore

# Cria a view index.html
cat <<EOT >> src/views/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Questionário</title>
  <link rel="stylesheet" href="/css/styles.css">
</head>
<body>
  <h1>Questionário de Ideias de Aplicativos</h1>
  <form action="/submit" method="POST">
    <label for="name">Nome:</label>
    <input type="text" id="name" name="name" required>
    <br>
    <label for="summary">Ideia de Aplicativo (Resumido):</label>
    <textarea id="summary" name="summary" required></textarea>
    <br>
    <label for="details">Ideia de Aplicativo (Detalhado):</label>
    <textarea id="details" name="details" required></textarea>
    <br>
    <button type="submit">Enviar</button>
  </form>
</body>
</html>
EOT

# Cria o arquivo questionnaire.html
cat <<EOT >> src/views/questionnaire.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Questionários Respondidos</title>
  <link rel="stylesheet" href="/css/styles.css">
</head>
<body>
  <h1>Questionários Respondidos</h1>
  <div id="responses"></div>
  <script>
    fetch('/responses')
      .then(res => res.json())
      .then(data => {
        const responsesDiv = document.getElementById('responses');
        data.forEach(response => {
          const div = document.createElement('div');
          div.innerHTML = \`<strong>Nome:</strong> \${response.name}<br>
          <strong>Resumo:</strong> \${response.summary}<br>
          <strong>Detalhes:</strong> \${response.details}<hr>\`;
          responsesDiv.appendChild(div);
        });
      });
  </script>
</body>
</html>
EOT

# Cria o arquivo CSS
cat <<EOT >> public/css/styles.css
body {
  font-family: Arial, sans-serif;
  margin: 20px;
}
form {
  margin-top: 20px;
}
label, input, textarea {
  display: block;
  margin: 10px 0;
}
button {
  padding: 10px 15px;
  background-color: #28a745;
  color: white;
  border: none;
  cursor: pointer;
}
button:hover {
  background-color: #218838;
}
EOT

# Cria o controller
cat <<EOT >> src/controllers/questionnaireController.ts
import { Request, Response } from 'express';
import Questionnaire from '../models/questionnaire';

// Submissão do formulário
export const submitForm = async (req: Request, res: Response) => {
  const { name, summary, details } = req.body;
  
  try {
    const newQuestionnaire = new Questionnaire({ name, summary, details });
    await newQuestionnaire.save();
    res.redirect('/responses');
  } catch (error) {
    res.status(500).send("Erro ao salvar o questionário.");
  }
};

// Exibir questionários respondidos
export const getResponses = async (req: Request, res: Response) => {
  try {
    const questionnaires = await Questionnaire.find();
    res.json(questionnaires);
  } catch (error) {
    res.status(500).send("Erro ao buscar os questionários.");
  }
};
EOT

# Cria o model
cat <<EOT >> src/models/questionnaire.ts
import { Schema, model } from 'mongoose';

const questionnaireSchema = new Schema({
  name: { type: String, required: true },
  summary: { type: String, required: true },
  details: { type: String, required: true },
}, {
  timestamps: true
});

export default model('Questionnaire', questionnaireSchema);
EOT

# Cria as rotas
cat <<EOT >> src/routes/index.ts
import { Router } from 'express';
import { submitForm, getResponses } from '../controllers/questionnaireController';

const router = Router();

router.post('/submit', submitForm);
router.get('/responses', getResponses);

export default router;
EOT

# Cria o servidor
cat <<EOT >> src/server.ts
import express from 'express';
import mongoose from 'mongoose';
import dotenv from 'dotenv';
import path from 'path';
import indexRoutes from './routes';

dotenv.config();

const app = express();

// Configura o MongoDB
mongoose.connect(process.env.MONGO_URI || '', { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('Conectado ao MongoDB'))
  .catch(err => console.error('Erro ao conectar ao MongoDB', err));

// Middleware
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, '../public')));
app.use('/', indexRoutes);

// Servir a página inicial
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, './views/index.html'));
});

// Servir a página de questionários respondidos
app.get('/responses-page', (req, res) => {
  res.sendFile(path.join(__dirname, './views/questionnaire.html'));
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(\`Servidor rodando na porta \${PORT}\`);
});
EOT

# Cria o Dockerfile
cat <<EOT >> Dockerfile
# Usando a imagem do Node.js
FROM node:14-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

CMD ["node", "dist/server.js"]
EOT

# Cria o arquivo docker-compose.yml
cat <<EOT >> docker-compose.yml
version: '3'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - MONGO_URI=mongodb://mongo:27017/questionnaireDB
    depends_on:
      - mongo
  mongo:
    image: mongo
    ports:
      - "27017:27017"
EOT

# Configura os scripts no package.json
sed -i 's/"scripts": {/"scripts": {\n    "start": "node dist\/server.js",\n    "dev": "nodemon src\/server.ts",/' package.json

# Comita e cria o repositório no GitHub
git add .
git commit -m "Projeto inicial"
echo "Criação do projeto concluída."

