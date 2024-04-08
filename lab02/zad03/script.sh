#!/bin/bash

cat <<EOF > Dockerfile
FROM node:16

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 8080

CMD [ "npm", "start" ]
EOF


cat <<EOF > package.json
{
  "name": "express-mongodb-app",
  "version": "1.0.0",
  "description": "A simple Express.js app with MongoDB",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  },
  "dependencies": {
    "express": "^4.17.1",
    "mongodb": "^4.0.0",
    "dotenv": "^10.0.0"
  }
}
EOF


cat <<EOF > index.js
const express = require('express');
const { MongoClient } = require('mongodb');
require('dotenv').config();

const app = express();
const PORT = 8080;

const uri = 'mongodb://mongo-container:27017/sklep';
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });

app.get('/', async (req, res) => {
  try {
    await client.connect();
    const database = client.db('sklep');
    const collection = database.collection('products');
    const result = await collection.find({}).toArray();
    res.json(result);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal Server Error' });
  } finally {
    await client.close();
  }
});

app.listen(PORT, () => {
  console.log(\`Server is running on port \${PORT}\`);
});
EOF

docker build -t express-mongodb-app .

docker start mongo-container

docker run -d --name express-app \
  -p 8080:8080 \
  --link mongo-container \
  express-mongodb-app

echo "Aplikacja została uruchomiona na porcie 8080."