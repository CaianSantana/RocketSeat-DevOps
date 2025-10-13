const express = require('express');
const mysql = require('mysql2');
const path = require('path');

const app = express();
const port = 3000;

// A configuração do EJS ainda pode ficar aqui, não atrapalha em nada.
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Configuração do pool de conexões (sem alterações)
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.USER,
  password: process.env.PASSWORD,
  database: process.env.DATABASE,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Rota principal modificada
app.get('/', (req, res) => {
  // 1. Tenta obter uma conexão do pool
  pool.getConnection((err, connection) => {
    // Se houver um erro, a conexão falhou
    if (err) {
      console.error('Falha ao obter conexão do pool:', err);
      res.status(500).send('<h1>Falha ao conectar ao banco de dados.</h1><p>Verifique o console para mais detalhes.</p>');
      return;
    }

    // 2. Se chegamos aqui, a conexão foi um sucesso!
    // Enviamos a mensagem de sucesso para a página.
    res.send('<h1>Consegui me conectar ao DB!</h1>');

    // 3. MUITO IMPORTANTE: Liberamos a conexão de volta para o pool.
    connection.release();
  });
});

app.listen(port, () => {
  console.log(`Servidor rodando com sucesso em http://localhost:${port}`);
  console.log('Abra seu navegador e acesse o endereço acima.');
});