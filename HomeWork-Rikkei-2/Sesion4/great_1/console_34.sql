set search_path to quanlysinhvien2

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    gender VARCHAR(10),
    birth_year INT,
    major VARCHAR(50),
    gpa DECIMAL(3,1)
);

INSERT INTO students (full_name, gender, birth_year, major, gpa) VALUES
    ('Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
    ('Trần Thị Bích Ngọc', 'Nữ', 2001, 'Kinh tế', 3.2),
    ('Lê Quốc Cường', 'Nam', 2003, 'CNTT', 2.7),
    ('Phạm Minh Anh', 'Nữ', 2000, 'Luật', 3.9),
    ('Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
    ('Lưu Đức Tài', 'Nam', 2004, 'Cơ khí', NULL),
    ('Võ Thị Thu Hằng', 'Nữ', 2001, 'CNTT', 3.0);

-- Chèn dữ liệu mới:
-- Thêm sinh viên “Phan Hoàng Nam”, giới tính Nam, sinh năm 2003, ngành CNTT, GPA 3.8
INSERT INTO students (full_name, gender, birth_year, major, gpa) VALUES
    ('Phan Hoàng Nam', 'Nam', 2003, 'CNTT', 3.8);
-- Cập nhật dữ liệu:
-- Sinh viên “Lê Quốc Cường” vừa cải thiện học lực, cập nhật gpa = 3.4
update students set gpa = 3.4
where id = 3;

-- Xóa dữ liệu:
-- Xóa tất cả sinh viên có gpa IS NULL
delete
from students
where gpa is null;

-- Truy vấn cơ bản:
-- Hiển thị sinh viên ngành CNTT có gpa >= 3.0, chỉ lấy 3 kết quả đầu tiên
select * from students
where gpa >= 3.0
order by gpa desc
limit 3;

-- Loại bỏ trùng lặp:
-- Liệt kê danh sách ngành học duy nhất
select distinct major from students;

-- Sắp xếp:
-- Hiển thị sinh viên ngành CNTT, sắp xếp giảm dần theo GPA, sau đó tăng dần theo tên
select * from students
where major = 'CNTT'
order by gpa asc;

select * from students
where major = 'CNTT'
order by full_name desc;

-- Tìm kiếm:
-- Tìm sinh viên có tên bắt đầu bằng “Nguyễn”
select * from students
where full_name ilike '%Nguyễn%';

-- Khoảng giá trị:
-- Hiển thị sinh viên có năm sinh từ 2001 đến 2003
select * from students
where birth_year between 2001 and 2003;