
-- Кількість чатів в залежності від рівня астролога
-- тут можна також використати INNER JOIN (або просто JOIN)
-- щоб показати тільки тих астрологів, які мають чати
SELECT 
    a.astrologer_level,
    COUNT(c.chat_id) AS chat_count
FROM astrologers a
LEFT JOIN chats c
    ON a.astrologer_id = c.astrologer_id
GROUP BY a.astrologer_level;


-- Ім'я астролога, кількість користувачів,
-- які з ним спілкувалися, кількість чатів з
-- максимальною оцінкою та максимальну тривалість
-- чату з астрологом
SELECT 
    a.astrologer_name,
    COUNT(DISTINCT c.user_id) AS user_count,
    SUM(CASE WHEN r.rating = 5 THEN 1 ELSE 0 END) AS max_rating_chats_count,
    MAX(c.session_duration) AS max_chat_duration
FROM astrologers a
LEFT JOIN chats c
    ON a.astrologer_id = c.astrologer_id
LEFT JOIN ratings r
    ON c.chat_id = r.chat_id
GROUP BY a.astrologer_name;


-- Ім'я астролога, середній рейтинг астролога,
-- суму зароблених ним грошей та долю його заробітку
-- від усієї заробленої суми. Обмежте результат виконання
-- запиту п'ятьма астрологами, доля заробітку яких була найвища.
WITH total_earnings AS (
    SELECT 
        SUM(c.session_duration * p.price) AS total_sum
    FROM chats c
    JOIN astrologers a
        ON c.astrologer_id = a.astrologer_id
    JOIN chat_pricing p
        ON a.astrologer_level = p.astrologer_level
), 
astrologer_earnings AS (
    SELECT
        a.astrologer_name,
        AVG(r.rating) AS average_rating,
        SUM(c.session_duration * p.price) AS total_earnings,
        SUM(c.session_duration * p.price) / (SELECT total_sum FROM total_earnings) AS earnings_share
    FROM chats c
    JOIN astrologers a
        ON c.astrologer_id = a.astrologer_id
    JOIN chat_pricing p
        ON a.astrologer_level = p.astrologer_level
    JOIN ratings r
        ON c.chat_id = r.chat_id
    GROUP BY a.astrologer_name
)
SELECT 
    astrologer_name,
    average_rating,
    total_earnings,
    earnings_share
FROM astrologer_earnings
ORDER BY earnings_share DESC
LIMIT 5;
