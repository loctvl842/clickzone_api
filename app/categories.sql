SELECT
  parent.id as id,
  parent.name as name,
  child.id as child_id,
  child.name as child_name
FROM category as parent
LEFT JOIN category_relationship as r ON parent.id = r.parent_id
LEFT JOIN category as child ON r.child_id = child.id
WHERE parent.id = 1
