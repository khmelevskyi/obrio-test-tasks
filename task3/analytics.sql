-- Активність астрологів і використання функціоналу пінгів
SELECT p.astrologer_id, COUNT(p.id) AS ping_count
FROM Pings p
GROUP BY p.astrologer_id;

-- Кількість пінгів
SELECT COUNT(*) AS total_pings
FROM Pings;

-- Конверсія з пінга в чат
SELECT 
    p.astrologer_id, 
    p.user_id, 
    COUNT(l.chat_id) AS chat_count
FROM Pings p
LEFT JOIN PingChatLinks l
    ON p.id = l.ping_id
GROUP BY p.astrologer_id, p.user_id;

-- Довжина чатів та дохід з них
SELECT 
    c.id, 
    c.session_length, 
    c.revenue
FROM Chats c
JOIN PingChatLinks l
    ON c.id = l.chat_id;

-- Статистика по конверсії типів користувачів
SELECT
    ut.type_name, 
    COUNT(l.chat_id) AS chat_count, 
    SUM(c.revenue) AS total_revenue
FROM Users u
JOIN UserTypes ut
    ON u.user_type_id = ut.id
LEFT JOIN PingChatLinks l
    ON u.id = l.user_id
LEFT JOIN Chats c
    ON l.chat_id = c.id
GROUP BY ut.type_name;
