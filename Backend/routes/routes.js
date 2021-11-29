//Cargue la conexión del grupo MySQL
const { request, response } = require("express");
const pool = require("../data/config");

//Ruta de la app
const router = (app) => {
  //Mostrar mensaje de bienvenida de root
  app.get("/", (request, response) => {
    response.send({
      message: "Bienvenido Eduardo a Node.js Express REST API!",
    });
  });

  //Mostrar todos los usuarios
  app.get("/users", (request, response) => {
    pool.query("SELECT * FROM users", (error, result) => {
      if (error) throw error;

      response.send(result);
    });
  });

  //Mostrar un solo usuario por ID
  app.get("/users/:id", (request, response) => {
    const id = request.params.id;

    pool.query("SELECT * FROM users WHERE id = ?", id, (error, result) => {
      if (error) throw error;

      response.send(result);
    });
  });

  //Agregar un nuevo usuario
  app.post("/users", (request, response) => {
    pool.query("INSERT INTO users SET ?", request.body, (error, result) => {
      if (error) throw error;

      response.status(201).send(`User added with ID: ${result.insertId}`);
    });
  });
};

//Exportar el router
module.exports = router;
