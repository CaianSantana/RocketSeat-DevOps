const express = require('express');
const mysql = require('mysql2');
const path = require('path');

const app = express();
const port = 3000;


const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.USER,
  password: process.env.PASSWORD,
  database: process.env.DATABASE,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

app.get('/', (req, res) => {
  pool.getConnection((err, connection) => {
    if (err) {
      console.error('Falha ao obter conexão do pool:', err);
      res.status(500).send('<h1>Falha ao conectar ao banco de dados.</h1><p>Verifique o console para mais detalhes.</p>');
      return;
    }

    res.send('<h1>Consegui me conectar ao DB!</h1>');

    connection.release();
  });
});

app.listen(port, () => {
  console.log(`Servidor rodando com sucesso em http://localhost:${port}`);
  console.log('Abra seu navegador e acesse o endereço acima.');
});