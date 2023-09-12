-- q4.sql
SELECT day, ordem, COUNT(DISTINCT latitude, longitude) AS num_unique_coordinates
FROM bus_data
GROUP BY day, ordem
ORDER BY day, num_unique_coordinates DESC;
