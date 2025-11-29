set search_path to elearning;

create table Students (
    student_id serial primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(50) unique not null
);
create table Instructors (
    instructor_id serial primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(50) unique not null
);
create table Courses (
    course_id serial primary key,
    course_name varchar(100) not null
);
create table Enrollments (
    enrollment_id serial primary key,
    enroll_date date not null
);
create table Assignments (
    assignment_id serial primary key,
    title varchar(100) not null,
    due_date date not null
);
create table Submissions (
    submissions_id serial primary key,
--     assignment_id
    submissions_date date not null,
    grade int check ( grade >= 0 and grade <= 100)
);

alter table Courses
add column instructor_id int references Instructors(instructor_id);

alter table Enrollments
add column student_id int references  Students(student_id);
alter table Enrollments
add column course_id int references  Courses(course_id);

alter table Assignments
add column course_id int references Courses(course_id);

alter table Submissions
add column assignment int references Assignments(assignment_id);
alter table Submissions
add column student_id int references Students(student_id);