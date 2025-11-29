set search_path to hotel

create table RoomTypes (
    room_type_id serial primary key,
    type_name varchar(50) not null unique,
    price_per_night numeric(10,2) check ( price_per_night > 0 ),
    max_capacity int check ( max_capacity > 0 )
);

create table Rooms (
    room_id serial primary key,
    room_number varchar(10) not null unique,
    status varchar(20) check ( status IN ('Available', 'Occupied', 'Maintenance' ))
);

create table Customers (
    customer_id serial primary key,
    full_name varchar(100) not null,
    email varchar(100) unique not null,
    phone varchar(15) not null
);

create table Bookings (
    booking_id serial primary key,
    check_in date not null,
    check_out date not null,
    status varchar(20) check ( status IN ('Pending', 'Confirmed', 'Cancelled') )
);

create table Payments (
    payment_id serial primary key,
    amount numeric(10,2) check ( amount >= 0 ),
    payment_date date not null,
    method varchar(20) check ( method IN ('Credit', 'Card', 'Cash', 'Bank Transfer') )
);

alter table Rooms
add column room_type_id int references RoomTypes(room_type_id);

alter table Bookings
add column customer_id int references Customers(customer_id);
alter table Bookings
add column room_id int references Rooms(room_id);

alter table Payments
add column booking_id int references Bookings(booking_id);