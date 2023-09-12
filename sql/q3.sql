-- q3.sql
SELECT day, ordem, MAX(velocidade) AS max_speed
FROM bus_data
GROUP BY day, ordem
ORDER BY day, max_speed DESC
LIMIT 3;
