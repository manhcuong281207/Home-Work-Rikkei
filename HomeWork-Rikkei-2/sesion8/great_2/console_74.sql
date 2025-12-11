set search_path to ss8_g2;

CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100),
                          price NUMERIC,
                          discount_percent INT
);
INSERT INTO products (name, price, discount_percent)
VALUES
    ('Bút Bi Thiên Long', 5000.00, 0),
    ('Tập Vở 100 Trang', 12000.00, 5),
    ('Balo Học Sinh', 250000.00, 10),
    ('Máy Tính Casio', 350000.00, 0),
    ('Hộp Bút Màu', 45000.00, 15),
    ('Sách Lịch Sử', 80000.00, 0),
    ('Bàn Phím USB', 150000.00, 5),
    ('Chuột Quang', 85000.00, 10),
    ('Tai Nghe Nhét Tai', 60000.00, 0),
    ('Sạc Dự Phòng', 400000.00, 20);

create or replace procedure calculate_discount(p_id_in int, out p_final_price numeric)
language plpgsql
as $$
    declare v_discount_percent numeric;
            v_price numeric;
            v_actual_discount_percent INT;
    begin
        select price, discount_percent into v_price, v_discount_percent from products
        where id = p_id_in;

        if v_discount_percent > 50 then
            v_actual_discount_percent := 50;
        else
            v_actual_discount_percent := v_discount_percent;
        end if;

        p_final_price = v_price - (v_price * v_discount_percent / 100);

        update products
        set price = p_final_price
        where id = p_id_in;
    end;
$$;

call calculate_discount(2, null);

