SELECT
  od.id,
  od.user_id,
  od.total,
  oi.quantity,
  p.name,
  u.username
FROM
order_details AS od
JOIN order_items AS oi ON od.id = oi.order_id
JOIN product AS p ON oi.product_id = p.id
JOIN user AS u ON u.id = od.user_id
