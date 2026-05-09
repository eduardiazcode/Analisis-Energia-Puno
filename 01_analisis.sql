-- VER DATOS DE LA TABLA
SELECT * FROM suministros;

-- ¿Cuántos suministros tiene cada provincia?
SELECT provincia, COUNT(*) AS cantidad_suministros
FROM suministros
GROUP BY provincia
ORDER BY cantidad_suministros DESC;

-- ¿Cuánto consume y factura cada provincia?
SELECT
    provincia,
    COUNT(*) AS total_suministros,
    ROUND(SUM(cea), 2) AS consumo_total_kwh,
    ROUND(AVG(cea), 2) AS consumo_promedio_kwh,
    ROUND(SUM(monto_total), 2) AS facturacion_total,
    ROUND(AVG(monto_total), 2) AS facturacion_promedio
FROM suministros
GROUP BY provincia
ORDER BY consumo_total_kwh DESC;


-- ¿Existen registros con consumo o monto negativo o en cero?
SELECT
    COUNT(*) AS total_registros,
    COUNT(*) FILTER (WHERE cea = 0) AS consumo_cero,
    COUNT(*) FILTER (WHERE cea < 0) AS consumo_negativo,
    COUNT(*) FILTER (WHERE monto_total = 0) AS monto_cero,
    COUNT(*) FILTER (WHERE monto_total < 0) AS monto_negativo
FROM suministros;

-- ¿Qué tipo de tarifa predomina y cuánto consume cada una?
SELECT
    tarifa,
    COUNT(*) AS total_suministros,
    ROUND(AVG(cea), 2) AS consumo_promedio_kwh,
    ROUND(AVG(monto_total), 2) AS facturacion_promedio
FROM suministros
WHERE monto_total > 0
GROUP BY tarifa
ORDER BY total_suministros DESC;

-- ¿Cuáles son los 10 distritos con mayor facturación promedio?
SELECT
    distrito,
    provincia,
    COUNT(*) AS total_suministros,
    ROUND(AVG(cea), 2) AS consumo_promedio_kwh,
    ROUND(AVG(monto_total), 2) AS facturacion_promedio
FROM suministros
WHERE monto_total > 0
GROUP BY distrito, provincia
ORDER BY facturacion_promedio DESC
LIMIT 10;