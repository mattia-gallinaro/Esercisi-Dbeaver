CREATE DATABASE esercizio;
USE esercizio;
CREATE TABLE pagella(
	nome nVARCHAR(30) NOT NULL,
	cognome nVARCHAR(30) NOT NULL,
	classe nVARCHAR(6) NOT NULL,
	voto_mate int NOT NULL CHECK(voto_mate >= 0 AND voto_mate <= 10),
	voto_it int NOT NULL CHECK(voto_it >= 0 AND voto_it <= 10),
	voto_info int NOT NULL CHECK(voto_info >= 0 AND voto_info <= 10),
	voto_storia int NOT NULL CHECK(voto_storia >= 0 AND voto_storia <= 10),
	voto_ing int NOT NULL CHECK(voto_ing >= 0 AND voto_ing <= 10),
	voto_tpsi int NOT NULL CHECK(voto_tpsi >= 0 AND voto_tpsi <= 10),
	voto_sistemi int NOT NULL CHECK(voto_sistemi >= 0 AND voto_sistemi <= 10),
	voto_gpoi int NOT NULL CHECK(voto_gpoi >= 0 AND voto_gpoi <= 10),
	voto_motoria int NOT NULL CHECK(voto_motoria >= 0 AND voto_motoria <= 10),
	voto_civica int NOT NULL CHECK(voto_civica >= 0 AND voto_civica <= 10),
	voto_reli int NOT NULL CHECK(voto_reli >= 0 AND voto_reli <= 10),
	comportamento int NOT NULL CHECK(comportamento >= 0 AND comportamento <= 10),
)
