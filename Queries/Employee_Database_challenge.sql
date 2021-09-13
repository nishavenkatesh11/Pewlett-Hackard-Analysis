--DELIVERABLE 1
-- Create Retirement Titles table
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    tl.title,
    tl.from_date,
    tl.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as tl
ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

--Create the Unique Titles table
-- Use Dictinct with Orderby to remove duplicate rows

SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

--Count number of employees retiring by title
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT DESC;

--DELIVERABLE 2
-- Create Mentorship Eligibility table
SELECT DISTINCT ON (emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	tl.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN titles as tl
ON (e.emp_no = tl.emp_no)
INNER JOIN dept_emp as de
ON (de.emp_no = e.emp_no)
WHERE de.to_date IN ('9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;