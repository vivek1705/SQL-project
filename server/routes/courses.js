const express = require("express");
const router = express.Router();
const db = require("../db");

router.get("/", (req, res) => {
  db.query("SELECT * FROM Courses", (err, results) => {
    if (err) throw err;
    res.json(results);
  });
});

router.post("/", (req, res) => {
  const { CourseName, DepartmentID } = req.body;
  db.query("INSERT INTO Courses (CourseName, DepartmentID) VALUES (?, ?)", [CourseName, DepartmentID], (err, result) => {
    if (err) throw err;
    res.json({ id: result.insertId });
  });
});

router.put("/:id", (req, res) => {
  const { CourseName, DepartmentID } = req.body;
  db.query("UPDATE Courses SET CourseName=?, DepartmentID=? WHERE CourseID=?", [CourseName, DepartmentID, req.params.id], (err) => {
    if (err) throw err;
    res.sendStatus(200);
  });
});

router.delete("/:id", (req, res) => {
  db.query("DELETE FROM Courses WHERE CourseID=?", [req.params.id], (err) => {
    if (err) throw err;
    res.sendStatus(200);
  });
});

module.exports = router;