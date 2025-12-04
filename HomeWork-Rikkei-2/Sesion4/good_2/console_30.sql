set search_path to quanlysanphamcuahang

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

INSERT INTO products (name, category, price, stock) VALUES
    ('Laptop Dell', 'Electronics', 1500.00, 5),
    ('Chuột Logitech', 'Electronics', 25.50, 50),
    ('Bàn phím Razer', 'Electronics', 120.00, 20),
    ('Tủ lạnh LG', 'Home Appliances', 800.00, 3),
    ('Máy giặt Samsung', 'Home Appliances', 600.00, 2);


-- Thêm sản phẩm mới: 'Điều hòa Panasonic', category 'Home Appliances', giá 400.00, stock 10
INSERT INTO products (name, category, price, stock) VALUES
    ('Điều hoà panasonic', 'Home Appliances', 400.00, 10);

-- Cập nhật stock của 'Laptop Dell' thành 7
update products set stock = 7
where id = 1;
-- Xóa các sản phẩm có stock bằng 0 (nếu có)
delete from products
where stock = 0;
-- Liệt kê tất cả sản phẩm theo giá tăng dần
select * from products
order by  price asc;
-- Liệt kê danh mục duy nhất của các sản phẩm (DISTINCT)
select distinct category from products;
-- Liệt kê sản phẩm có giá từ 100 đến 1000
select * from products
where price between 100 and 1000;
-- Liệt kê các sản phẩm có tên chứa từ 'LG' hoặc 'Samsung' (sử dụng LIKE/ILIKE)
select * from products
where name ilike '%LG%' or name ilike '%Sam%';
-- Hiển thị 2 sản phẩm đầu tiên theo giá giảm dần, hoặc lấy sản phẩm thứ 2 đến thứ 3 bằng LIMIT và OFFSET
select * from products
order by  price asc limit 3 offset 2;