CREATE DATABASE registration_1;

USE registration_1;

CREATE TABLE notebook(
	date_vote DATE,
	id_student INT ,
	name_stud nVARCHAR(20) ,
	surname_stud nVARCHAR(20) ,
	name_subject nVARCHAR(15),
	grade DECIMAL(10,2),
	name_teacher nVARCHAR(20),
	surname_teacher nVARCHAR(20),
	class_stud nVARCHAR(2),
	section_stud nVARCHAR(1),
	note nVARCHAR(100)
);


CREATE TABLE student(
	id_student INT PRIMARY KEY,
	name_student nVARCHAR(30) NOT NULL,
	surname_student nVARCHAR(30) NOT NULL,
)

CREATE TABLE class(
	id_class INT IDENTITY(1,1) PRIMARY KEY,
	year_class INT NOT NULL,
	section_class nVARCHAR(3) NOT NULL
)

CREATE TABLE teacher(
	id_teacher INT IDENTITY(1,1) PRIMARY KEY,
	name_teacher nVARCHAR(30) NOT NULL,
	surname_teacher nVARCHAR(30) NOT NULL,
)

CREATE TABLE subject(
	id_subject INT IDENTITY(1,1) PRIMARY KEY,
	name_subject nVARCHAR(30) NOT NULL
)

INSERT INTO student(id_student, name_student, surname_student)
SELECT DISTINCT n.id_student, n.name_stud, n.surname_stud
FROM notebook n
WHERE 1=1;

INSERT INTO class(year_class, section_class)
SELECT DISTINCT n.class_stud, n.section_stud
FROM notebook n
WHERE 1=1;

INSERT INTO subject(name_subject)
SELECT DISTINCT n.name_subject
FROM notebook n
WHERE 1=1;

INSERT INTO teacher (name_teacher, surname_teacher)
SELECT DISTINCT n.name_teacher, n.surname_teacher
FROM notebook n
WHERE 1=1;

CREATE TABLE student_class(
	id_stud_class INT IDENTITY(1,1) PRIMARY KEY,
	id_student INT FOREIGN KEY REFERENCES student(id_student),
	id_class INT FOREIGN KEY REFERENCES class(id_class),
	CONSTRAINT fk_student_class UNIQUE(id_student, id_class)
)

INSERT INTO student_class(id_student, id_class)
SELECT DISTINCT s.id_student, c.id_class
FROM notebook n
LEFT JOIN student s ON s.id_student = n.id_student
LEFT JOIN class c ON c.year_class = n.class_stud AND c.section_class = n.section_stud


CREATE TABLE teacher_subject_class(
	id_teacher_subject_class INT IDENTITY(1,1) PRIMARY KEY,
	id_teacher INT FOREIGN KEY REFERENCES teacher(id_teacher),
	id_subject INT FOREIGN KEY REFERENCES subject(id_subject),
	id_class INT FOREIGN KEY REFERENCES class(id_class),
	CONSTRAINT fk_teacher_subject_class UNIQUE(id_teacher, id_subject, id_class) 
)


INSERT INTO teacher_subject_class(id_teacher, id_subject, id_class)
SELECT DISTINCT t.id_teacher, s.id_subject ,c.id_class
FROM notebook n
LEFT JOIN teacher t ON t.name_teacher = n.name_teacher  AND t.surname_teacher = n.surname_teacher 
LEFT JOIN subject s ON s.name_subject = n.name_subject
LEFT JOIN class c ON c.year_class = n.class_stud AND c.section_class = n.section_stud

CREATE TABLE grade_stud(
	date_grade DATE NOT NULL,
	grade INT NOT NULL,
	id_teacher_subject_class INT FOREIGN KEY REFERENCES teacher_subject_class(id_teacher_subject_class) NOT NULL,
	id_stud_class INT FOREIGN KEY REFERENCES student_class(id_stud_class) NOT NULL
)


INSERT INTO grade_stud(date_grade, grade, id_teacher_subject_class, id_stud_class)
SELECT n.date_vote, n.grade, tcs.id_teacher_subject_class, stc.id_stud_class 
FROM notebook n
LEFT JOIN teacher t ON t.name_teacher = n.name_teacher  AND t.surname_teacher = n.surname_teacher 
LEFT JOIN subject s ON s.name_subject = n.name_subject
LEFT JOIN class c ON c.year_class = n.class_stud AND c.section_class = n.section_stud
LEFT JOIN student st ON st.id_student = n.id_student
LEFT JOIN teacher_subject_class tcs ON tcs.id_teacher  = t.id_teacher AND tcs.id_subject = s.id_subject AND tcs.id_class = c.id_class
LEFT JOIN student_class stc ON stc.id_student = st.id_student AND stc.id_class = c.id_class 

