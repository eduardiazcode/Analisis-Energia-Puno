-- Vista 1: resumen por provincia
CREATE VIEW v_resumen_provincia AS
SELECT
    provincia,
    COUNT(*) AS total_suministros,
    ROUND(SUM(cea), 2) AS consumo_total_kwh,
    ROUND(AVG(cea), 2) AS consumo_promedio_kwh,
    ROUND(SUM(monto_total), 2) AS facturacion_total,
    ROUND(AVG(monto_total), 2) AS facturacion_promedio
FROM suministros
WHERE monto_total > 0
GROUP BY provincia
ORDER BY consumo_total_kwh DESC;

-- Vista 2: resumen por tipo de tarifa
CREATE VIEW v_resumen_tarifa AS
SELECT
    tarifa,
    COUNT(*) AS total_suministros,
    ROUND(AVG(cea), 2) AS consumo_promedio_kwh,
    ROUND(AVG(monto_total), 2) AS facturacion_promedio
FROM suministros
WHERE monto_total > 0
GROUP BY tarifa
ORDER BY total_suministros DESC;

-- Vista 3: top 10 distritos por facturación promedio
CREATE VIEW v_top_distritos AS
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

-- Vista 4: distribución de suministros por distrito
CREATE VIEW v_suministros_distrito AS
SELECT
    distrito,
    provincia,
    COUNT(*) AS total_suministros,
    ROUND(SUM(monto_total), 2) AS facturacion_total
FROM suministros
WHERE monto_total > 0
GROUP BY distrito, provincia
ORDER BY total_suministros DESC;