const express = require("express");
const router = express.Router();
const db = require("../db");

router.get("/", (req, res) => {
  db.query("SELECT * FROM Students", (err, results) => {
    if (err) throw err;
    res.json(results);
  });
});

router.post("/", (req, res) => {
  const { Name, Gender, DOB, DepartmentID, Year } = req.body;
  db.query(
    "INSERT INTO Students (Name, Gender, DOB, DepartmentID, Year) VALUES (?, ?, ?, ?, ?)",
    [Name, Gender, DOB, DepartmentID, Year],
    (err, result) => {
      if (err) throw err;
      res.json({ id: result.insertId });
    }
  );
});

router.put("/:id", (req, res) => {
  const { Name, Gender, DOB, DepartmentID, Year } = req.body;
  db.query(
    "UPDATE Students SET Name=?, Gender=?, DOB=?, DepartmentID=?, Year=? WHERE StudentID=?",
    [Name, Gender, DOB, DepartmentID, Year, req.params.id],
    (err) => {
      if (err) throw err;
      res.sendStatus(200);
    }
  );
});

router.delete("/:id", (req, res) => {
  db.query("DELETE FROM Students WHERE StudentID=?", [req.params.id], (err) => {
    if (err) throw err;
    res.sendStatus(200);
  });
});

module.exports = router;