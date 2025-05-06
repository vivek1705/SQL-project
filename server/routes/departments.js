const express = require("express");
const router = express.Router();
const db = require("../db");

router.get("/", (req, res) => {
  db.query("SELECT * FROM Departments", (err, results) => {
    if (err) throw err;
    res.json(results);
  });
});

router.post("/", (req, res) => {
  const { DepartmentName } = req.body;
  db.query("INSERT INTO Departments (DepartmentName) VALUES (?)", [DepartmentName], (err, result) => {
    if (err) throw err;
    res.json({ id: result.insertId });
  });
});

router.put("/:id", (req, res) => {
  const { DepartmentName } = req.body;
  db.query("UPDATE Departments SET DepartmentName=? WHERE DepartmentID=?", [DepartmentName, req.params.id], (err) => {
    if (err) throw err;
    res.sendStatus(200);
  });
});

router.delete("/:id", (req, res) => {
  db.query("DELETE FROM Departments WHERE DepartmentID=?", [req.params.id], (err) => {
    if (err) throw err;
    res.sendStatus(200);
  });
});

module.exports = router;