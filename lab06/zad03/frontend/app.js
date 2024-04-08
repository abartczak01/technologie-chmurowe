const express = require("express");
const app = express();
const port = 8080;

const axios = require("axios");

app.use(express.json());

app.get("/", (req, res) => {
  axios.get("http://backend:3000/users").then((response) => {
    const { users } = response.data;

    const site = "<h1>Users:</h1>";
    const users_string = users
      .map(
        (user) =>
          `<li>${user.firstName} ${user.lastName}, year of birth ${user.yearOfBirth}</li>`
      )
      .join("");

    res.send(site + users_string);
  });
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
