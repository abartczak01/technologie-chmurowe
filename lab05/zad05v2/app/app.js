const express = require("express");
const app = express();
const port = 3000;

app.get("/sample", (req, res) => {
  res.send("Witaj w moim prostym serwerze Express!");
});

app.listen(port, () => {
  console.log(`Serwer Express nasłuchuje na porcie ${port}`);
});
