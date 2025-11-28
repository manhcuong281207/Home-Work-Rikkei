set search_path to university;
CREATE TABLE if not exists Students (
    students_id serial primary key,
    first_name varchar(50) not null ,
    last_name varchar(50) not null ,
    birth_date date not null ,
    email varchar(50) not null unique
);

CREATE TABLE if not exists Courses (
    course_id serial primary key,
    course_name varchar(100) not null ,
    credits int
);

CREATE TABLE if not exists Enrollments (
    enrollment_id int primary key,
    enroll_date date
);

ALTER TABLE Enrollments
ADD COLUMN students_id int REFERENCES Students(students_id);
ALTER TABLE Enrollments
ADD COLUMN course_id int REFERENCES Courses(course_id);