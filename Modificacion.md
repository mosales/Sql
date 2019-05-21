```sql
SET SCHEMA 'public';

DROP TABLE IF EXISTS campus;

CREATE TABLE campus(
                    campus_id SERIAL PRIMARY KEY,
                    nombre VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS division;

CREATE TABLE division(
                      division_id SERIAL PRIMARY KEY,
                      nombre VARCHAR (50) NOT NULL,
                      campus_id INT NOT NULL REFERENCES campus (campus_id)
);
```
