const express = require("express");
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
});
