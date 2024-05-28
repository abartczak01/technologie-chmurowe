const express = require("express");
const redis = require("redis");
const { Pool } = require("pg");

const app = express();

// Konfiguracja Redis
const redisClient = redis.createClient({
  url: "redis://redis:6379",
});

redisClient.on("error", (err) => console.log("Redis Client Error", err));
redisClient.on("connect", () => console.log("Connected to Redis"));

(async () => {
  await redisClient.connect();
})();

// Konfiguracja PostgreSQL
const pgClient = new Pool({
  user: "postgres",
  host: "postgres",
  database: "postgres",
  password: "password",
  port: 5432,
});

pgClient
  .connect()
  .then(() => console.log("Connected to PostgreSQL"))
  .catch((err) => console.error("PostgreSQL Client Error", err));

pgClient.query(`
    CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100)
    );
`);

app.use(express.json());

app.post("/message", async (req, res) => {
  const { message } = req.body;
  try {
    const reply = await redisClient.lPush("messages", message);
    res.send({ success: true, length: reply });
  } catch (err) {
    res.status(500).send(err.toString());
  }
});

app.get("/messages", async (req, res) => {
  try {
    const messages = await redisClient.lRange("messages", 0, -1);
    res.send({ messages });
  } catch (err) {
    res.status(500).send(err.toString());
  }
});

// Endpoint do dodawania użytkowników do PostgreSQL
app.post("/user", async (req, res) => {
  const { name } = req.body;
  try {
    const result = await pgClient.query(
      "INSERT INTO users (name) VALUES ($1) RETURNING *",
      [name]
    );
    res.send(result.rows[0]);
  } catch (err) {
    res.status(500).send(err.toString());
  }
});

// Endpoint do pobierania użytkowników z PostgreSQL
app.get("/users", async (req, res) => {
  try {
    const result = await pgClient.query("SELECT * FROM users");
    res.send(result.rows);
  } catch (err) {
    res.status(500).send(err.toString());
  }
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
