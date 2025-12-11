set search_path to ss8_g1;

CREATE TABLE employees (
                           emp_id SERIAL PRIMARY KEY,
                           emp_name VARCHAR(100),
                           job_level INT,
                           salary NUMERIC
);

INSERT INTO employees (emp_name, job_level, salary)
VALUES
    ('Nguyễn Văn An', 3, 48000.00),
    ('Trần Thị Bình', 2, 35000.00),
    ('Lê Văn Cường', 3, 52000.00),
    ('Phạm Thị Dung', 1, 28000.00),
    ('Hoàng Văn Em', 2, 38000.00),
    ('Đỗ Thị Giang', 3, 49500.00),
    ('Vũ Văn Hùng', 1, 30000.00),
    ('Bùi Thị Kim', 2, 36500.00),
    ('Dương Văn Long', 3, 55000.00),
    ('Mai Thị Nga', 1, 27500.00);

create or replace procedure adjust_salary(emp_id_in int, out p_new_salary numeric)
language plpgsql
as $$
    declare emp_id_select int;
            old_salary numeric;
    begin
--      truy vấn dữ liệu cần thiết & lưu vào biến
        select job_level, salary into emp_id_select, old_salary from employees
        where emp_id = emp_id_in;

--       rẽ nhánh kiêm tra điều kiện
        if emp_id_select = 1 then
            p_new_salary := old_salary * 1.05;
        elseif emp_id_select = 2 then
            p_new_salary := old_salary * 1.10;
        elseif emp_id_select = 3 then
            p_new_salary := old_salary * 1.15;
        end if;

-- cập nhật luôn vào bảng chính
    update employees
        set salary = p_new_salary
        where emp_id = emp_id_in;
    end;
$$;

call adjust_salary(10, null);