set search_path to ss7_k2;

CREATE TABLE customer (
                          customer_id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          email VARCHAR(100),
                          phone VARCHAR(15)
);

CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES customer(customer_id),
                        total_amount DECIMAL(10,2),
                        order_date DATE
);

INSERT INTO customer (full_name, email, phone) VALUES
                                                   ('Nguyễn Văn A', 'nguyenvana@example.com', '0123456789'),
                                                   ('Trần Thị B', 'tranthib@example.com', '0987654321'),
                                                   ('Lê Văn C', 'levanc@example.com', '0112233445'),
                                                   ('Phạm Thị D', 'phamthid@example.com', '0998877665');

INSERT INTO orders (customer_id, total_amount, order_date) VALUES
                                                               (1, 1500.00, '2024-01-15'),
                                                               (1, 2000.00, '2024-02-10'),
                                                               (2, 1200.50, '2024-03-05'),
                                                               (3, 2500.75, '2024-01-25'),
                                                               (4, 1800.00, '2024-02-20'),
                                                               (2, 1600.00, '2024-03-15');


-- Tạo một View tên v_order_summary hiển thị:
-- full_name, total_amount, order_date
-- (ẩn thông tin email và phone)
create view v_order_summary as
 select c.full_name, o.total_amount, o.order_date
     from customer c join orders o on c.customer_id = o.customer_id;

-- Viết truy vấn để xem tất cả dữ liệu từ View
select *
    from v_order_summary;

-- Cập nhật tổng tiền đơn hàng thông qua View (gợi ý: dùng WITH CHECK OPTION nếu cần)
create view v_order_totalamount as
    select  order_id, total_amount from orders
    where total_amount > 1000
    with check option;

update v_order_totalamount
    set total_amount = 2000
    where order_id = 1;

select * from v_order_totalamount;

-- Tạo một View thứ hai v_monthly_sales thống kê tổng doanh thu mỗi tháng
create view v_monthy_sales as
    select date_trunc('month', order_date) as month,
           sum(orders.total_amount) as total_revenue
    from orders
    group by date_trunc('month', order_date)
    order by month;

select * from v_monthy_sales;

-- Thử DROP View và ghi chú sự khác biệt giữa DROP VIEW và DROP MATERIALIZED VIEW trong PostgreSQL