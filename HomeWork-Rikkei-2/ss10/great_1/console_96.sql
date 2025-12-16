set search_path to ss10_g2;

CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          name VARCHAR(100) NOT NULL,
                          stock INT NOT NULL CHECK (stock >= 0)
);

INSERT INTO products (name, stock) VALUES
                                       ('Laptop Dell', 50),
                                       ('iPhone 15', 30),
                                       ('Bàn phím cơ', 100),
                                       ('Chuột gaming', 120),
                                       ('Màn hình LG', 40),
                                       ('Tai nghe Sony', 60),
                                       ('Ổ cứng SSD 1TB', 70),
                                       ('RAM 16GB', 90),
                                       ('Webcam Logitech', 35),
                                       ('Loa Bluetooth', 80);

CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        product_id INT NOT NULL,
                        quantity INT NOT NULL CHECK (quantity > 0),
                        CONSTRAINT fk_orders_product
                            FOREIGN KEY (product_id)
                                REFERENCES products(product_id)
);

INSERT INTO orders (product_id, quantity) VALUES
                                              (1, 2),
                                              (2, 1),
                                              (3, 5),
                                              (4, 3),
                                              (5, 1),
                                              (6, 4),
                                              (7, 2),
                                              (8, 6),
                                              (9, 1),
                                              (10, 3);

-- Khi có đơn hàng mới, trừ số lượng tồn kho tương ứng
create or replace function fn_reduce_stock_after_order_insert()
returns trigger as $$
    begin
        update  ss10_g2.products
        set stock = stock - new.quantity
        where product_id = new.product_id;

        return new;
    end;
$$ language plpgsql;

create trigger trig_reduce_stock_after_order_insert
after insert on orders
for each row
execute function fn_reduce_stock_after_order_insert();

-- Khi đơn hàng bị chỉnh sửa, cập nhật tồn kho tương ứng với sự thay đổi số lượng
create or replace function fn_adjust_stock_after_order_update()
returns trigger as $$
    declare diff int;
    begin
        diff := new.quantity - old.quantity;

        update ss10_g2.products
        set stock = stock - diff
        where product_id = new.product_id;

    return new;
    end;
$$ language plpgsql;

create trigger trig_adjust_stock_after_order_update
after update on orders
for each row
execute function fn_adjust_stock_after_order_update();

-- Khi đơn hàng bị xóa, trả lại số lượng vào tồn kho
create or replace function fn_restore_stock_after_order_delete()
returns trigger as $$
    begin
        update ss10_g2.products
        set stock = stock + old.quantity
        where product_id = old.product_id;

    return old;
    end;
$$ language plpgsql;

create trigger trig_restore_stock_after_order_delete
after delete on orders
for each row
execute function fn_restore_stock_after_order_delete();