const express = require("express");
const cors = require("cors");
const { Pool } = require("pg");

const app = express();
app.use(cors());

const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT || 5432,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

app.get("/api/info", async (req, res) => {
  try {
    const result = await pool.query("SELECT NOW() AS now");
    res.json({ env: process.env.APP_ENV, dbTime: result.rows[0].now });
  } catch (err) {
    res.status(500).json({ env: process.env.APP_ENV, error: err.message });
  }
});

app.listen(3000, () => console.log("API escuchando en el puerto 3000"));