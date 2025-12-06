set search_path to quanlydoanhsobanhang

CREATE TABLE products (
    product_id serial PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

CREATE TABLE orders (
    order_id serial PRIMARY KEY,
    product_id INT,
    quantity INT,
    total_price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products ( product_name, category)
VALUES
    ('Laptop Dell', 'Electronics'),
    ('IPhone 15', 'Electronics'),
    ('Bàn học gỗ', 'Furniture'),
    ('Ghế xoay', 'Furniture');

INSERT INTO orders (order_id, product_id, quantity, total_price)
VALUES
    (101, 1, 2, 2200),
    (102, 2, 3, 3300),
    (103, 3, 5, 2500),
    (104, 4, 4, 1600),
    (105, 1, 1, 1100);

-- Viết truy vấn hiển thị tổng doanh thu (SUM(total_price)) và số lượng sản phẩm bán được (SUM(quantity)) cho từng nhóm danh mục (category)
-- Đặt bí danh cột như sau:
-- total_sales cho tổng doanh thu
-- total_quantity cho tổng số lượng
-- Sắp xếp kết quả theo tổng doanh thu giảm dần
-- Chỉ hiển thị những nhóm có tổng doanh thu lớn hơn 2000
select p.product_id, p.product_name,  sum(o.total_price) as total_sales, sum(case
                                            when quantity isnull then 0
                                            else quantity
                                        end) as total_quantity
    from orders o left join products p on o.product_id = p.product_id
    group by p.product_id, p.product_name
    having sum(o.total_price) > 2000
    order by total_sales desc;

-- Viết truy vấn con (Subquery) để tìm sản phẩm có doanh thu cao nhất trong bảng orders
select p.product_id, p.product_name,  sum(o.total_price) as total_sales
from orders o left join products p on o.product_id = p.product_id
group by p.product_id, p.product_name
having sum(o.total_price) >= all (select sum(o.total_price) as total_sales
                                  from orders o left join products p on o.product_id = p.product_id
                                  group by p.product_id, p.product_name
                                  );

-- Hiển thị: product_name, total_revenue
-- Viết truy vấn hiển thị tổng doanh thu theo từng nhóm category (dùng JOIN + GROUP BY)
select p.category, sum(o.total_price) as total_sales
from products p left join orders o on o.product_id = p.product_id
group by p.category
order by total_sales desc;
-- Dùng INTERSECT để tìm ra nhóm category có sản phẩm bán chạy nhất (ở câu 1) cũng nằm trong danh sách nhóm có tổng doanh thu lớn hơn 3000
