	
---Level 1 (1)---

SELECT * 
FROM employees
WHERE Salary = (SELECT MIN(Salary) FROM employees);

	
---Level 1 (2)---

SELECT * 
FROM Products
WHERE price > (SELECT AVG(Price) from Products);

---Level 2 (3)---

SELECT e.name, d.department_name 
FROM departments d
JOIN employees e
ON d.id =e.department_id
AND d.department_name = 'Sales';

---Level 2 (4)---

SELECT c.customer_id, c.name, o.order_id
FROM customers c
left JOIN orders o
ON c.customer_id = o.customer_id
WHERE  order_id IS NULL

---Level 3 (5)---

SELECT category_id,
      MAX(price) AS MaxPrice
FROM products
GROUP BY category_id;

---Level 3 (6)---

SELECT TOP 1 e.name, d.department_name, e.salary
FROM employees e
JOIN departments d
ON e.id = d.id
AND Salary > (SELECT AVG(Salary) FROM employees );

---Level 4 (7)---

SELECT e.name, d.department_name, e.salary
FROM employees e
JOIN departments d
ON e.id = d.id
AND Salary > (SELECT AVG(Salary) FROM employees );

---Level 4 (8)---

SELECT s.student_Id, s.name, g.course_id, g.grade
FROM grades  g
JOIN (
	SELECT course_id,  MAx(grade) AS MaxGrade 
	FROM grades 
	Group by course_id
)  m
ON g.course_id = m.course_id
AND g.grade = m.MaxGrade
JOIN Students s
ON s.student_id = g.student_id
;
---Level 5 (9)---

SELECT *
FROM (
	SELECT *,
		 DENSE_RANK() OVER (Partition by category_id order by price desc) as ran
	FROM Products
) ran
Where ran.ran = 3;

---Level 5 (10)---

SELECT *
FROM employees 
WHERE Salary > (SELECT AVG(Salary) from employees)
AND Salary < (select max(salary) from employees);