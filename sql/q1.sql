-- q1.sql
SELECT linha AS company, COUNT(DISTINCT ordem) AS num_bus_lines
FROM bus_data
GROUP BY linha;
