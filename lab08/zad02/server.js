const express = require("express");
const redis = require("redis");

const app = express();
const client = redis.createClient({
  url: "redis://redis:6379", // użyj poprawnego URL do połączenia z serwisem Redis
});

client.on("error", (err) => console.log("Redis Client Error", err));
client.on("connect", () => console.log("Connected to Redis"));

(async () => {
  await client.connect();
})();

app.use(express.json());

app.post("/message", async (req, res) => {
  const { message } = req.body;
  try {
    const reply = await client.lPush("messages", message);
    res.send({ success: true, length: reply });
  } catch (err) {
    res.status(500).send(err.toString());
  }
});

app.get("/messages", async (req, res) => {
  try {
    const messages = await client.lRange("messages", 0, -1);
    res.send({ messages });
  } catch (err) {
    res.status(500).send(err.toString());
  }
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
