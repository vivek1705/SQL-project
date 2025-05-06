function switchTab(tabName) {
  document.querySelectorAll(".tab-content").forEach((tab) =>
    tab.classList.remove("active")
  );
  document.getElementById(tabName).classList.add("active");
}

function setupCrud(entity, fields) {
  const form = document.getElementById(`${entity}Form`);
  const list = document.getElementById(`${entity}List`);
  let editId = null;

  function fetchItems() {
    fetch(`/api/${entity}`)
      .then((res) => res.json())
      .then((data) => {
        list.innerHTML = "";

        data.forEach((item) => {
          const tr = document.createElement("tr");

          // Render all fields including ID
          fields.forEach((field) => {
            const td = document.createElement("td");
            td.textContent = item[field];
            tr.appendChild(td);
          });

          // Action buttons
          const actionTd = document.createElement("td");

          const editBtn = document.createElement("button");
          editBtn.textContent = "Edit";
          editBtn.onclick = () => editItem(entity, item[fields[0]]); // fields[0] = ID

          const deleteBtn = document.createElement("button");
          deleteBtn.textContent = "Delete";
          deleteBtn.onclick = () => deleteItem(entity, item[fields[0]]);

          actionTd.appendChild(editBtn);
          actionTd.appendChild(deleteBtn);
          tr.appendChild(actionTd);

          list.appendChild(tr);
        });
      });
  }

  window.editItem = function (entityType, id) {
    fetch(`/api/${entityType}`)
      .then((res) => res.json())
      .then((data) => {
        const idField = `${entityType.slice(0, -1)}ID`;
        const item = data.find((i) => i[idField] === id);
        if (item) {
          fields.forEach((field) => {
            if (form[field]) form[field].value = item[field];
          });
          form.dataset.editId = id;
        }
      });
  };

  window.deleteItem = function (entityType, id) {
    if (confirm("Are you sure?")) {
      fetch(`/api/${entityType}/${id}`, {
        method: "DELETE",
      }).then(() => fetchItems());
    }
  };

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const data = Object.fromEntries(new FormData(form).entries());
    const id = form.dataset.editId;
    const method = id ? "PUT" : "POST";
    const url = id ? `/api/${entity}/${id}` : `/api/${entity}`;

    fetch(url, {
      method,
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(data),
    }).then(() => {
      form.reset();
      delete form.dataset.editId;
      fetchItems();
    });
  });

  fetchItems();
}

// 💡 Pass ID field as the first element so it's rendered first and used for edit/delete
setupCrud("students", ["StudentID", "Name", "Gender", "DOB", "DepartmentID", "Year"]);
setupCrud("departments", ["DepartmentID", "DepartmentName"]);
setupCrud("courses", ["CourseID", "CourseName", "DepartmentID"]);
setupCrud("enrollments", ["EnrollmentID", "StudentID", "CourseID", "Marks"]);
