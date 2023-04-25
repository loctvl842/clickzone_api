SELECT
  p.id,
  p.name,
  p.image_url,
  p.category_id,
  c.name as category_name,
  p.price,
  p.old_price,
  p.description,
  p.created_at,
  p.modified_at
FROM product as p
LEFT JOIN category as c ON p.category_id = c.id
WHERE LOWER(p.name) LIKE '%ban phim co%'
ORDER BY modified_at DESC
LIMIT 0, 4
