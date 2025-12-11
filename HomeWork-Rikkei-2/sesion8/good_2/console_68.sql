set search_path to ss8_k2;

CREATE TABLE inventory (
                           product_id SERIAL PRIMARY KEY,
                           product_name VARCHAR(100),
                           quantity INT
);

INSERT INTO inventory (product_name, quantity)
VALUES
    ('Laptop Gaming X5', 50),
    ('Chuột không dây M3', 200),
    ('Bàn phím cơ K10', 80),
    ('Ổ cứng SSD 512GB', 150),
    ('Màn hình 27 inch', 65),
    ('Tai nghe Bluetooth', 300),
    ('Webcam HD Pro', 90),
    ('Cáp HDMI 2m', 450),
    ('USB Flash 64GB', 500),
    ('Loa máy tính mini', 120);

-- Viết một Procedure có tên check_stock(p_id INT, p_qty INT) để:
-- Kiểm tra xem sản phẩm có đủ hàng không
-- Nếu quantity < p_qty, in ra thông báo lỗi bằng RAISE EXCEPTION ‘Không đủ hàng trong kho’
create or replace procedure check_stock(product_id_in int, quantity_in int)
language plpgsql
as $$
    begin
        if (select quantity from inventory
        where product_id = product_id_in) < quantity_in then
            raise notice 'Không đủ hàng trong kho';
        else
            raise notice 'còn đủ hàng';
        end if;
    end;
$$;
-- Gọi Procedure với các trường hợp:
-- Một sản phẩm có đủ hàng
-- Một sản phẩm không đủ hàng
call check_stock(2, 100);
call check_stock(3, 90);