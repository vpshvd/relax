SELECT CONCAT(DAY(o.created_at), '.', MONTH(o.created_at), '.', YEAR(o.created_at)) date, SUM(SUBSTR(o.total_price, 5))/100 total, COUNT(o.id) count,
       (SELECT SUM(SUBSTR(o1.total_price, 5))/100
        FROM checkout_order o1 JOIN checkout_order_client c1 ON c1.order_id = o1.id
        WHERE o1.status = 5 AND c1.phone != '380737771913' AND DAY(o1.created_at) = DAY(o.created_at) AND MONTH(o1.created_at) = MONTH(o.created_at)) total_completed,
       (SELECT count(o2.id)
        FROM checkout_order o2 JOIN checkout_order_client c2 ON c2.order_id = o2.id
        WHERE o2.status = 5 AND c2.phone != '380737771913' AND DAY(o2.created_at) = DAY(o.created_at) AND MONTH(o2.created_at) = MONTH(o.created_at)) count_completed,
       (SELECT SUM(SUBSTR(o1.total_price, 5))/100
        FROM checkout_order o1 JOIN checkout_order_client c1 ON c1.order_id = o1.id JOIN checkout_order_payment p ON p.order_id = o1.id AND p.payment_type_id = 1
        WHERE c1.phone != '380737771913' AND DAY(o1.created_at) = DAY(o.created_at) AND MONTH(o1.created_at) = MONTH(o.created_at)) total_liqpay,
       (SELECT count(o2.id)
        FROM checkout_order o2 JOIN checkout_order_client c2 ON c2.order_id = o2.id JOIN checkout_order_payment p ON p.order_id = o2.id AND p.payment_type_id = 1
        WHERE c2.phone != '380737771913' AND DAY(o2.created_at) = DAY(o.created_at) AND MONTH(o2.created_at) = MONTH(o.created_at)) count_liqpay
FROM checkout_order o
         JOIN checkout_order_client c ON c.order_id = o.id
WHERE c.phone != '380737771913'
GROUP BY YEAR(o.created_at), MONTH(o.created_at), DAY(o.created_at)
ORDER BY YEAR(o.created_at) DESC, MONTH(o.created_at) DESC, DAY(o.created_at) DESC