set search_path to phantichdoanhthu;

CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           customer_name VARCHAR(100),
                           city VARCHAR(100)
);

CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT,
                        order_date DATE,
                        total_price NUMERIC(10,2),
                        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
                             item_id SERIAL PRIMARY KEY,
                             order_id INT,
                             product_id INT,
                             quantity INT,
                             price NUMERIC(10,2),
                             FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO customers (customer_name, city)
VALUES
    ('Nguyễn Văn A', 'Hà Nội'),
    ('Trần Thị B', 'Đà Nẵng'),
    ('Lê Văn C', 'Hồ Chí Minh'),
    ('Phạm Thị D', 'Hà Nội');

INSERT INTO orders (customer_id, order_date, total_price)
VALUES
    (1, '2024-12-20', 3000),
    (2, '2025-01-05', 2000),
    (1, '2025-02-10', 2500),
    (3, '2025-02-15', 1000),
    (4, '2025-03-01', 800);

INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
    (1, 1, 2, 1500),   -- item 1
    (2, 2, 1, 1500),   -- item 2
    (3, 3, 4, 500),    -- item 3
    (4, 2, 2, 1000);   -- item 4


-- Viết truy vấn hiển thị tổng doanh thu và tổng số đơn hàng của mỗi khách hàng:
-- Dùng ALIAS: total_revenue và order_count
select c.customer_id, c.customer_name, count(o.order_id) as order_count, sum(o.total_price) as total_revenue
    from customers c left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c
order by customer_id desc;

-- Chỉ hiển thị khách hàng có tổng doanh thu > 2000
select c.customer_id, c.customer_name, sum(o.total_price) as total_revenue
from customers c left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c
having sum(o.total_price) > 2000
order by customer_id desc;

-- Viết truy vấn con (Subquery) để tìm doanh thu trung bình của tất cả khách hàng
-- Sau đó hiển thị những khách hàng có doanh thu lớn hơn mức trung bình đó
select c.customer_id, c.customer_name, sum(o.total_price) as total_revenue
from customers c left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having sum(o.total_price) > (select AVG(total_rev)
                                    from (
                                        select SUM(total_price) as total_rev
                                        from orders
                                        group by customer_id
                                    ) as t)
order by total_revenue desc;

-- Dùng HAVING + GROUP BY để lọc ra thành phố có tổng doanh thu cao nhất
select c.city, sum(o.total_price) as total_revenue
from customers c left join orders o on c.customer_id = o.customer_id
group by c.city
having sum(o.total_price) =( select max(city_revenue)
                                    from (
                                        select SUM(o.total_price) as city_revenue
                                        from customers c join orders o on c.customer_id = o.customer_id
                                        group by c.city
                                    ) as t)
-- (Mở rộng) Hãy dùng INNER JOIN giữa customers, orders, order_items để hiển thị chi tiết:
-- Tên khách hàng, tên thành phố, tổng sản phẩm đã mua, tổng chi tiêu
select c.customer_id, c.city, sum(oi.quantity) as total_products, sum(oi.quantity * oi.price) as total_spending
from customers c
inner join orders o on c.customer_id = o.customer_id
inner join order_items oi on o.order_id = oi.order_id
group by c.customer_id, customer_name, city
order by total_spending desc;