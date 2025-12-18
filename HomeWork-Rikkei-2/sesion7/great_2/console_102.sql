set search_path to ss7_g2;
-- Bảng khách hàng
CREATE TABLE customer (
                          customer_id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          region VARCHAR(50)
);

-- Bảng đơn hàng
CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES customer(customer_id),
                        total_amount DECIMAL(10,2),
                        order_date DATE,
                        status VARCHAR(20)
);

-- Bảng sản phẩm
CREATE TABLE product (
                         product_id SERIAL PRIMARY KEY,
                         name VARCHAR(100),
                         price DECIMAL(10,2),
                         category VARCHAR(50)
);

-- Bảng chi tiết đơn hàng
CREATE TABLE order_detail (
                              order_id INT REFERENCES orders(order_id),
                              product_id INT REFERENCES product(product_id),
                              quantity INT
);


INSERT INTO customer (full_name, region) VALUES
                                             ('Nguyễn Văn A', 'Hà Nội'),
                                             ('Trần Thị B', 'TP.HCM'),
                                             ('Lê Văn C', 'Đà Nẵng'),
                                             ('Phạm Thị D', 'Hà Nội'),
                                             ('Hoàng Văn E', 'Cần Thơ');

INSERT INTO product (name, price, category) VALUES
                                                ('Laptop Dell', 20000000, 'Electronics'),
                                                ('iPhone 14', 25000000, 'Electronics'),
                                                ('Tai nghe Sony', 3000000, 'Accessories'),
                                                ('Bàn phím cơ', 1500000, 'Accessories'),
                                                ('Ghế gaming', 5000000, 'Furniture'),
                                                ('Bàn làm việc', 7000000, 'Furniture');

INSERT INTO orders (customer_id, total_amount, order_date, status) VALUES
                                                                       (1, 28000000, '2024-01-10', 'COMPLETED'),
                                                                       (2, 25000000, '2024-01-15', 'COMPLETED'),
                                                                       (3, 4500000,  '2024-02-05', 'COMPLETED'),
                                                                       (1, 7000000,  '2024-02-20', 'CANCELLED'),
                                                                       (4, 20000000, '2024-03-01', 'COMPLETED'),
                                                                       (5, 8500000,  '2024-03-10', 'PENDING');

INSERT INTO order_detail (order_id, product_id, quantity) VALUES
-- Order 1
(1, 1, 1),
(1, 3, 2),

-- Order 2
(2, 2, 1),

-- Order 3
(3, 4, 1),
(3, 3, 1),

-- Order 4 (bị huỷ)
(4, 6, 1),

-- Order 5
(5, 1, 1),

-- Order 6
(6, 5, 1),
(6, 4, 1);



CREATE OR REPLACE VIEW v_revenue_by_region AS
SELECT
    c.region,
    SUM(o.total_amount) AS total_revenue
FROM customer c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region;

SELECT *
FROM v_revenue_by_region
ORDER BY total_revenue DESC
LIMIT 3;



CREATE OR REPLACE VIEW v_order_detail_updatable AS
SELECT
    order_id,
    customer_id,
    total_amount,
    order_date,
    status
FROM orders
WHERE status <> 'CANCELLED'
        WITH CHECK OPTION;

UPDATE v_order_detail_updatable
SET status = 'COMPLETED'
WHERE order_id = 6;


CREATE OR REPLACE VIEW v_revenue_above_avg AS
SELECT *
FROM v_revenue_by_region
WHERE total_revenue >
      (
          SELECT AVG(total_revenue)
          FROM v_revenue_by_region
      );

SELECT * FROM v_revenue_above_avg;


