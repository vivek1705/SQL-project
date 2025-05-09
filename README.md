
# 🎓 College CRUD Web Application

A full-stack web application for managing students, departments, courses, and enrollments using Node.js, Express, JavaScript, and MySQL. Users can perform **Create, Read, Update, Delete (CRUD)** operations on each entity via a clean and responsive UI.

---

## 📁 Project Structure

```

college-crud-app/
├── public/
│   ├── index.html
│   └── script.js
├── server/
│   ├── app.js
│   ├── db.js
│   └── routes/
│       ├── students.js
│       ├── departments.js
│       ├── courses.js
│       └── enrollments.js
├── CollegeDB.sql
├── package.json
└── README.md

````


## ⚙️ Technologies Used

- Node.js
- Express.js
- MySQL
- JavaScript (Vanilla)
- HTML & CSS

---

## 🚀 Features

- Perform CRUD operations for:
  - Students
  - Departments
  - Courses
  - Enrollments
- UI with dynamic tab-based navigation
- Displays data in tabular format
- Inline editing & deletion
- Responsive & interactive frontend

---

## 🏁 Getting Started

### 1. Clone the Repository

```bash
git clone [https://github.com/yourusername/college-crud-app.git](https://github.com/vivek1705/SQL-project.git)
cd college-crud-app
````

### 2. Install Dependencies

```bash
npm install
```

### 3. Setup MySQL Database

* Open your MySQL client (e.g., MySQL Workbench, phpMyAdmin, or CLI)
* Create a database:

```sql
CREATE DATABASE CollegeDB;
```

* Import the provided SQL file:

```bash
source CollegeDB.sql;
```

Or from CLI:

```bash
mysql -u root -p CollegeDB < CollegeDB.sql
```

### 4. Configure Database Connection

Edit `server/db.js`:

```js
const pool = mysql.createPool({
  host: "localhost",
  user: "your_mysql_user",
  password: "your_mysql_password",
  database: "CollegeDB",
});
```

Replace `your_mysql_user` and `your_mysql_password` with your actual credentials.

---

### 5. Run the Application

```bash
npm start
```

Visit [http://localhost:3000](http://localhost:3000) in your browser.

---

## 🌐 API Endpoints

Each entity has RESTful endpoints:

* `GET /api/students`
* `POST /api/students`
* `PUT /api/students/:id`
* `DELETE /api/students/:id`

(Same for `/departments`, `/courses`, `/enrollments`)

