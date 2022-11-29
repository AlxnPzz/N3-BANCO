# Os eventos nas próximas 5 semanas
SELECT DATA_EVENTO, descricao FROM evento
WHERE DATA_EVENTO BETWEEN NOW() and DATE_ADD(NOW(), INTERVAL 5 week)
ORDER BY DATA_EVENTO ASC