SELECT
  p.id,
  p.name,
  /* p.image_url, */
  /* p.category_id, */
  c.name as category_name,
  p.price
  /* p.old_price, */
  /* p.description, */
  /* p.created_at, */
  /* p.modified_at */
FROM product as p
LEFT JOIN category as c ON p.category_id = c.id
JOIN (
  SELECT
    parent.id as id,
    parent.name as name,
    child.id as child_id,
    child.name as child_name
  FROM category as parent
  LEFT JOIN category_relationship as r ON parent.id = r.parent_id
  LEFT JOIN category as child ON r.child_id = child.id
  WHERE parent.id = 1
) as r ON r.id = p.category_id || r.child_id = p.category_id
ORDER BY price DESC
LIMIT 0, 4
