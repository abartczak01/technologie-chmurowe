const express = require("express");
const app = express();

app.get("/", (req, res) => {
  const currentDate = new Date();
  res.json({ currentDateTime: currentDate });
});

const port = 8080;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
