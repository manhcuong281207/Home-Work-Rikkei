set search_path to ss10_k1;

-- Tạo bảng products với các cột: id, name, price, last_modified
CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(255) NOT NULL,
                          price NUMERIC(10, 2) NOT NULL,
                          last_modified TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO products (name, price) VALUES
                                       ('Laptop A', 1200.00),
                                       ('Smartphone X', 799.50),
                                       ('Keyboard Gaming', 150.99);

create or replace function update_last_modified()
returns trigger
as $$
    begin
        new.last_modified = now();
        return new;
    end;
$$ language plpgsql;
-- Tạo Trigger trg_update_last_modified gắn với bảng products để gọi Function trước khi thực hiện UPDATE
create trigger trg_update_last_modified
before update on products
for each row
execute function update_last_modified();
-- Thực hành:
-- Chèn dữ liệu mẫu vào bảng products
INSERT INTO products (name, price) VALUES
('Monitor 27 inch', 350.75);
-- Thử UPDATE giá sản phẩm và kiểm tra xem trường last_modified đã được cập nhật chưa
update products
set price = 90000
where name = 'Smartphone X';
