CREATE DATABASE esercizio_registro2;

USE esercizio_registro2;

CREATE TABLE assegnazioni(
	data_assegnazione DATE,
	id_matricola INT ,
	nome_stud nVARCHAR(20) ,
	cognome_stud nVARCHAR(20) ,
	materia nVARCHAR(15),
	voto nVARCHAR(10),
	nome_doc nVARCHAR(20),
	cognome_doc nVARCHAR(20),
	classe nVARCHAR(2),
	sezione nVARCHAR(1),
	note nVARCHAR(100)
);

BULK INSERT assegnazioni
FROM 'C:\Users\galli\Downloads\Esempi di taccuino voti - Foglio1 (1).csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
);

CREATE TABLE studente(
	id_stud INT PRIMARY KEY,
	nome_stud nVARCHAR(20) NOT NULL,
	cognome_stud nVARCHAR(20) NOT NULL,
	classe nVARCHAR(2) NOT NULL,
	sezione nVARCHAR(2) NOT NULL
);

INSERT INTO studente(id_stud, nome_stud,cognome_stud, classe, sezione)
SELECT DISTINCT a.id_matricola ,a.nome_stud ,a.cognome_stud, a.classe , a.sezione 
FROM assegnazioni a
WHERE 1=1

CREATE TABLE docente(
	id_doc INT IDENTITY(1,1) PRIMARY KEY,
	nome_doc nVARCHAR(20) NOT NULL,
	cognome_doc nVARCHAR(20) NOT NULL
);

INSERT INTO docente(nome_doc, cognome_doc)
SELECT DISTINCT a.nome_doc , a.cognome_doc
FROM assegnazioni a
WHERE 1=1

CREATE TABLE materia(
	id_materia INT IDENTITY(1,1) PRIMARY KEY,
	materia nVARCHAR(15) NOT NULL
);

INSERT INTO materia(materia)
SELECT DISTINCT a.materia
FROM assegnazioni a
WHERE 1=1

CREATE TABLE voto(
	id_stud INT NOT NULL,
	id_doc INT NOT NULL,
	id_materia INT NOT NULL,
	voto DECIMAL NOT NULL,
	data_voto DATE NOT NULL,
	note TEXT
)


INSERT INTO voto(id_stud,id_doc, id_materia, voto, data_voto, note)
SELECT s.id_stud,d.id_doc, m.id_materia, CONVERT(DECIMAL,  REPLACE(a.voto, ',', '')), a.data_assegnazione , a.note 
FROM assegnazioni a
LEFT JOIN studente s ON a.nome_stud = s.nome_stud AND a.cognome_stud = s.cognome_stud
LEFT JOIN docente d ON a.nome_doc = d.nome_doc  AND a.cognome_doc = d.cognome_doc 
LEFT JOIN materia m ON a.materia = m.materia 