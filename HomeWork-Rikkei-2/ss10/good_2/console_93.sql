set search_path to ss10_k2;

CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           credit_limit NUMERIC
);

INSERT INTO customers (name, credit_limit)
VALUES
    ('Nguyễn Trọng Đại', 50000000.00),
    ('Lê Thị Hồng', 25000000.00),
    ('Trần Văn Minh', 100000000.00),
    ('Phạm Thanh Thảo', 15000000.00),
    ('Hoàng Đức Anh', 75000000.00),
    ('Vũ Ngọc Hà', 30000000.00),
    ('Đỗ Quang Vinh', 80000000.00),
    ('Bùi Thu Trang', 40000000.00),
    ('Dương Đình Phúc', 60000000.00),
    ('Mai Thanh Tùng', 20000000.00);

CREATE TABLE orders (
                    order_id SERIAL PRIMARY KEY,
                    customer_id INT NOT NULL,
                    order_amount NUMERIC,
                    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (customer_id, order_amount)
VALUES
    (1, 1500000.00), -- Nguyễn Trọng Đại
    (3, 5000000.00), -- Trần Văn Minh
    (1, 250000.00),  -- Nguyễn Trọng Đại (đơn hàng thứ 2)
    (5, 1200000.00), -- Hoàng Đức Anh
    (2, 750000.00),  -- Lê Thị Hồng
    (10, 300000.00), -- Mai Thanh Tùng
    (7, 4000000.00), -- Đỗ Quang Vinh
    (3, 1000000.00), -- Trần Văn Minh (đơn hàng thứ 2)
    (6, 600000.00),  -- Vũ Ngọc Hà
    (4, 900000.00);  -- Phạm Thanh Thảo

-- Tạo bảng customers (có id, name, credit_limit) và bảng orders (id, customer_id, order_amount)
-- Viết Function check_credit_limit() để kiểm tra tổng giá trị đơn hàng của khách hàng trước khi insert đơn mới. Nếu vượt hạn mức, raise exception
-- Tạo Trigger trg_check_credit gắn với bảng orders để gọi Function trước khi insert

create or replace function check_credit_limit()
returns trigger as $$
    declare
        v_credit_limit numeric;
    begin
        select credit_limit into v_credit_limit
        from ss10_k2.customers
        where customer_id = new.customer_id;

        if new.order_amount > v_credit_limit then
            raise exception 'vượt quá hạn mức cho phép';
        end if;
        return new;
    end;
$$ language plpgsql;
DROP TRIGGER IF EXISTS trg_check_credit ON orders;
DROP FUNCTION IF EXISTS check_credit_limit();
create trigger trg_check_credit
before insert on orders
for each row
    execute function check_credit_limit();
-- Thực hành:
-- Chèn dữ liệu mẫu vào customers
-- Thử insert các đơn hàng, bao gồm cả trường hợp vượt hạn mức
-- Kiểm tra Trigger có ngăn chặn insert khi vượt hạn mức không
