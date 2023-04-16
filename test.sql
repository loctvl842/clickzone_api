SELECT
  cart_item.id,
  cart_item.quantity,
  product.name,
  product.image_url,
  product.price
FROM cart_item
  LEFT JOIN product
  ON cart_item.product_id = product.id
WHERE session_id = 3;
