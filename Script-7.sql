USE esercizio;

SELECT nome, cognome FROM pagella WHERE voto_mate >= 9;

SELECT nome, cognome FROM pagella WHERE voto_mate <= 5;

SELECT nome, cognome FROM pagella 
WHERE ((voto_mate + voto_it + voto_info 
+ voto_storia + voto_ing + voto_tpsi + voto_sistemi 
+ voto_gpoi + voto_motoria + voto_civica 
+ voto_reli + comportamento) / 12) < 6;

SELECT cognome, nome, voto_it FROM pagella WHERE nome LIKE 'M%';

SELECT nome , cognome , 
((voto_mate + voto_it + voto_info + 
voto_storia + voto_ing + voto_tpsi + 
voto_sistemi + voto_gpoi + voto_motoria 
+ voto_civica + voto_reli + comportamento) / 12) 
AS media FROM pagella WHERE 1=1;

SELECT nome , cognome , voto_it FROM pagella WHERE cognome LIKE ('%e%');

SELECT nome, cognome, voto_info  FROM pagella WHERE voto_info >= 9 ORDER BY nome ASC;

SELECT nome, cognome , voto_info FROM pagella WHERE 1=1 ORDER BY cognome DESC;

SELECT nome, cognome , comportamento  FROM pagella WHERE voto_sistemi >= 6 AND comportamento = 10;

SELECT nome, cognome FROM pagella WHERE nome LIKE '%a';

SELECT cognome , voto_reli  FROM pagella WHERE nome IN('Mattia', 'Andrea');

SELECT nome, cognome FROM pagella 
WHERE ((voto_mate + voto_it + voto_info 
+ voto_storia + voto_ing + voto_tpsi + voto_sistemi 
+ voto_gpoi + voto_motoria + voto_civica 
+ voto_reli + comportamento) / 12) >= 8;