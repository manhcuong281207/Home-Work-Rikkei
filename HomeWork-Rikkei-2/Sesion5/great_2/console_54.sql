create schema quanlydoanhthu2;

CREATE TABLE customers (
                               customer_id SERIAL PRIMARY KEY,
                               customer_name VARCHAR(100),
                               city VARCHAR(50)
);

CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES customers(customer_id),
                        order_date DATE,
                        total_amount NUMERIC(10,2)
);

CREATE TABLE order_items (
                             item_id SERIAL PRIMARY KEY,
                             order_id INT REFERENCES orders(order_id),
                             product_name VARCHAR(100),
                             quantity INT,
                             price NUMERIC(10,2)
);

INSERT INTO customers (customer_name, city) VALUES
                                                ('Nguyễn Văn A', 'Hà Nội'),
                                                ('Trần Thị B', 'Đà Nẵng'),
                                                ('Hoàng Văn C', 'Hà Nội'),
                                                ('Phạm Minh D', 'Hồ Chí Minh'),
                                                ('Vũ Hà E', 'Đà Nẵng');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
                                                               (1, '2024-01-10', 3000),
                                                               (1, '2024-02-12', 1500),
                                                               (2, '2024-03-05', 800),
                                                               (3, '2024-01-22', 5000),
                                                               (4, '2024-02-15', 12000),
                                                               (5, '2024-02-18', 900),
                                                               (4, '2024-03-01', 7000);

INSERT INTO order_items (order_id, product_name, quantity, price) VALUES
                                                                      (1, 'Laptop Dell', 1, 3000),
                                                                      (2, 'Chuột Logitech', 3, 500),
                                                                      (3, 'Bàn phím cơ', 1, 800),
                                                                      (4, 'Tivi Samsung', 1, 5000),
                                                                      (5, 'iPhone 15', 1, 12000),
                                                                      (6, 'Tai nghe Sony', 2, 450),
                                                                      (7, 'Ghế gaming', 1, 7000);


-- ALIAS:
-- Hiển thị danh sách tất cả các đơn hàng với các cột:
-- Tên khách (customer_name)
-- Ngày đặt hàng (order_date)
-- Tổng tiền (total_amount)
select c.customer_name, o.order_date, o.total_amount
    from customers c join orders o on c.customer_id = o.customer_id;

-- Aggregate Functions:
-- Tính các thông tin tổng hợp:
-- Tổng doanh thu (SUM(total_amount))
-- Trung bình giá trị đơn hàng (AVG(total_amount))
-- Đơn hàng lớn nhất (MAX(total_amount))
-- Đơn hàng nhỏ nhất (MIN(total_amount))
-- Số lượng đơn hàng (COUNT(order_id))

select c.customer_name, o.order_date, o.total_amount
from customers c join orders o on c.customer_id = o.customer_id;

-- GROUP BY / HAVING:
-- Tính tổng doanh thu theo từng thành phố
-- chỉ hiển thị những thành phố có tổng doanh thu lớn hơn 10.000
select c.city, sum(o.total_amount) as Total_city
    from customers c join orders o on c.customer_id = o.customer_id
    group by c.city;

-- JOIN:
-- Liệt kê tất cả các sản phẩm đã bán, kèm:
-- Tên khách hàng
-- Ngày đặt hàng
-- Số lượng và giá
-- (JOIN 3 bảng customers, orders, order_items)
select c.customer_name, o.order_date, oi.quantity, oi.price
from customers c join orders o on c.customer_id = o.customer_id
                 join order_items oi on o.order_id = oi.order_id;

-- Subquery:
-- Tìm tên khách hàng có tổng doanh thu cao nhất.
-- Gợi ý: Dùng SUM(total_amount) trong subquery để tìm MAX
select c.customer_name, sum(o.total_amount)
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_name
having sum(o.total_amount) >= all (select sum(o.total_amount)
                                   from customers c join orders o on c.customer_id = o.customer_id
                                   group by c.customer_name)

-- UNION và INTERSECT:
-- Dùng UNION để hiển thị danh sách tất cả thành phố có khách hàng hoặc có đơn hàng
-- Dùng INTERSECT để hiển thị các thành phố vừa có khách hàng vừa có đơn hàng