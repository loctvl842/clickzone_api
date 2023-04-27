SELECT
  c.id,
  cr.parent_id
FROM
category AS c
LEFT JOIN category_relationship AS cr
ON cr.child_id = c.id
WHERE
c.id = 9

