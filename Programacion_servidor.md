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

------
CREATE OR REPLACE FUNCTION funcionCondicion (edad INT)
RETURNS VARCHAR(20)
AS
$$
DECLARE
		clasificacion VARCHAR (20);
BEGIN
	  IF (edad >= 0 AND edad <= 3) THEN
	  			clasificacion = 'bebe';
	  ELSE
	  		IF(edad >= 4 AND edad <= 10) THEN
	  			clasificacion = 'niño';
			END IF;
		END IF;
		
		RETURN clasificacion;
END 
$$
LANGUAGE plpgsql;

SELECT funcionCondicion(4);
---------------------------
CREATE OR REPLACE FUNCTION funcionCondicion (clasificacion VARCHAR(50) )
RETURNS VARCHAR(20)
AS
$$
DECLARE
		rango VARCHAR (20);
BEGIN
	  CASE clasificacion
	  		WHEN 'bebe' THEN rango = 'tiene de 0 a 3 años';
	  		WHEN 'niño' THEN rango = 'tiene de 4 a 10 años';
			ELSE rango = 'tiene mas de 10 años';
	  END CASE;
		
		RETURN rango;
END 
$$
LANGUAGE plpgsql;

SELECT funcionCondicion ('bebe');

---------------------------------
CREATE OR REPLACE FUNCTION funcionCiclo (numero INT)
RETURNS BOOLEAN AS $$
DECLARE 
		cont INT := 0;
		producto INT :=0;
BEGIN
	LOOP
			EXIT WHEN cont=11;
			SELECT numero * cont INTO producto;
			raise notice 'Producto: %', producto;
			cont = cont +1;
	END LOOP;
	
	RETURN TRUE;
END
$$
LANGUAGE plpgsql;

SELECT funcionCiclo (10);

```
