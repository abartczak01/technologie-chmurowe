const express = require("express");
const { MongoClient } = require("mongodb");

const app = express();
const port = 3000;
app.use(express.json());

const uri = "mongodb://db:27017/mydatabase";
const client = new MongoClient(uri, {});

app.post("/setup", async (req, res) => {
  try {
    await client.connect();
    const database = client.db("mydatabase");
    await database.createCollection("items");
    res.send("Database and collection setup successfully");
  } catch (error) {
    console.error(error);
    res.status(500).send("Error setting up database and collection");
  } finally {
    await client.close();
  }
});

app.post("/add", async (req, res) => {
  try {
    await client.connect();
    const database = client.db("mydatabase");
    const collection = database.collection("items");
    const newItem = req.body;
    await collection.insertOne(newItem);
    res.send("Item added successfully");
  } catch (error) {
    console.error(error);
    res.status(500).send("Error adding item");
  } finally {
    await client.close();
  }
});

app.get("/", async (req, res) => {
  try {
    await client.connect();
    const database = client.db("mydatabase");
    const collection = database.collection("items");
    const items = await collection.find({}).toArray();
    res.json(items);
  } catch (error) {
    console.error(error);
    res.status(500).send("Error fetching items");
  } finally {
    await client.close();
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
