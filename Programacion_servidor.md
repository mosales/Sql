# CREACIÓN DE FUNCIONES DEL LADO DEL SERVIDOR SQL :unicorn:

```sql

CREATE FUNCTION prueba1 (INT, INT) RETURNS INT AS $$
BEGIN
		RETURN $1 * $2;
END
$$
LANGUAGE plpgsql;

SELECT prueba1(5,2);
-------------------------------------------------------
CREATE FUNCTION prueba2 (n1 INT, n2 INT) RETURNS INT AS $$
BEGIN
		RETURN n1 * n2;
END
$$
LANGUAGE plpgsql;

SELECT prueba1(5,2);
SELECT prueba2(5,3);
---------------------------------------------
DROP FUNCTION prueba2(INT, INT);
--------------------------------------------------
CREATE OR REPLACE FUNCTION prueba2 (n1 FLOAT, n2 FLOAT) RETURNS FLOAT AS $$
BEGIN
		RETURN n1 * n2;
END
$$
LANGUAGE plpgsql;

SELECT prueba2(5.0,3.3);
-----------------------------------
CREATE OR REPLACE FUNCTION es_multiplo (n1 INT, n2 INT) RETURNS BOOLEAN AS $$
DECLARE 
	    di INT;
		df FLOAT;
		r BOOLEAN := TRUE;
BEGIN
		di :=n1/n2;
		df := n1::FLOAT / n2::FLOAT;
		IF (df > di) THEN
		         r= FALSE;
	    END IF;
		
		RETURN r;
END
$$
LANGUAGE plpgsql;

DROP FUNCTION es_multiplo(int, int);

SELECT es_multiplo(5,2);
```
