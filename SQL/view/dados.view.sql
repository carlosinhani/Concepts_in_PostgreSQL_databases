CREATE TABLE IF NOT EXISTS funcionarios (
    id SERIAL,
	nome VARCHAR(50),
	gerente INTEGER,
	PRIMARY KEY (id),
	FOREIGN KEY (gerente) REFERENCES funcionarios(id)
);

INSERT INTO funcionarios (nome, gerente) VALUES ('João Paulo',null);
INSERT INTO funcionarios (nome, gerente) VALUES ('Betriz',1);
INSERT INTO funcionarios (nome, gerente) VALUES ('Priscila',1);
INSERT INTO funcionarios (nome, gerente) VALUES ('Daiane',2);
INSERT INTO funcionarios (nome, gerente) VALUES ('Luiz Eduardo',4);

SELECT id, nome, gerente FROM funcionarios WHERE gerente IS NULL
UNION ALL
SELECT id, nome, gerente FROM funcionarios WHERE id = 999; -- APENAS PARA EXEMPLIFICAR

CREATE OR REPLACE RECURSIVE VIEW vw_func(id, gerente, funcionarios) AS (
    SELECT id, gerente, nome
	FROM funcionarios
	WHERE gerente IS NULL
	
	UNION ALL
	
	SELECT funcionarios.id, funcionarios.gerente, funcionarios.nome
	FROM funcionarios 
	JOIN vw_func ON vw_func.id = funcionarios.gerente
);

SELECT id, gerente, funcionarios FROM vw_func;