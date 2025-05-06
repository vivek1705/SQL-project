const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");

const app = express();
app.use(cors());
app.use(bodyParser.json());
app.use(express.static("public"));

const studentRoutes = require("./routes/students");
const deptRoutes = require("./routes/departments");
const courseRoutes = require("./routes/courses");
const enrollRoutes = require("./routes/enrollments");

app.use("/api/students", studentRoutes);
app.use("/api/departments", deptRoutes);
app.use("/api/courses", courseRoutes);
app.use("/api/enrollments", enrollRoutes);

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});