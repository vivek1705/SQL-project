const express = require("express");
const router = express.Router();
const db = require("../db");

router.get("/", (req, res) => {
  db.query("SELECT * FROM Enrollments", (err, results) => {
    if (err) throw err;
    res.json(results);
  });
});

router.post("/", (req, res) => {
  const { StudentID, CourseID, Marks } = req.body;
  db.query("INSERT INTO Enrollments (StudentID, CourseID, Marks) VALUES (?, ?, ?)", [StudentID, CourseID, Marks], (err, result) => {
    if (err) throw err;
    res.json({ id: result.insertId });
  });
});

router.put("/:id", (req, res) => {
  const { StudentID, CourseID, Marks } = req.body;
  db.query("UPDATE Enrollments SET StudentID=?, CourseID=?, Marks=? WHERE EnrollmentID=?", [StudentID, CourseID, Marks, req.params.id], (err) => {
    if (err) throw err;
    res.sendStatus(200);
  });
});

router.delete("/:id", (req, res) => {
  db.query("DELETE FROM Enrollments WHERE EnrollmentID=?", [req.params.id], (err) => {
    if (err) throw err;
    res.sendStatus(200);
  });
});

module.exports = router;