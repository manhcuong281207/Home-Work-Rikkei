set search_path to ss8_k2;

CREATE TABLE order_detail (
                              id SERIAL PRIMARY KEY,
                              order_id INT,
                              product_name VARCHAR(100),
                              quantity INT,
                              unit_price NUMERIC
);


INSERT INTO order_detail (order_id, product_name, quantity, unit_price)
VALUES
    (101, 'Laptop Gaming X5', 1, 1200.00),
    (101, 'Chuột không dây M3', 2, 25.50),
    (102, 'Bàn phím cơ K10', 1, 75.99),
    (103, 'Ổ cứng SSD 512GB', 3, 45.00),
    (104, 'Màn hình 27 inch', 1, 199.99),
    (105, 'Tai nghe Bluetooth', 5, 30.00),
    (106, 'Webcam HD Pro', 1, 49.90),
    (107, 'Cáp HDMI 2m', 4, 10.00),
    (108, 'USB Flash 64GB', 10, 8.50),
    (109, 'Loa máy tính mini', 2, 15.00);

-- Viết một Stored Procedure có tên calculate_order_total(order_id_input INT, OUT total NUMERIC)
-- Tham số order_id_input: mã đơn hàng cần tính
-- Tham số total: tổng giá trị đơn hàng
-- Trong Procedure:
-- Viết câu lệnh tính tổng tiền theo order_id
-- Gọi Procedure để kiểm tra hoạt động với một order_id cụ thể

create or replace procedure calculate_order_total(order_id_in int, out total numeric)
language plpgsql
as $$
    begin
        select sum(quantity * unit_price) into total from order_detail
        where order_id = order_id_in;
    end;
    $$;
call calculate_order_total(101, null)