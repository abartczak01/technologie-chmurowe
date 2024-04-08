#!/bin/bash

mkdir express-app
cd express-app

echo '{
  "name": "docker-express",
  "version": "1.0.0",
  "description": "Dockerized Express.js application",
  "dependencies": {
    "express": "^4.17.1"
  }
}' > package.json

npm install

echo 'const express = require("express");
const app = express();

app.get("/", (req, res) => {
  const currentDate = new Date();
  res.json({ "currentDateTime": currentDate });
});

const port = 8080;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
' > index.js

docker run -p 8080:8080 -v "$(pwd)":/usr/src/app -w /usr/src/app node:14 node index.js
