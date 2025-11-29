set search_path to sales;

create table Customers (
    customer_id serial primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(50) unique not null,
    phone varchar(10) not null
);
create table Products (
    product_id serial primary key,
    product_name varchar(100) not null,
    price int not null,
    stock_quantity int not null
);
create table Orders (
    order_id serial primary key,
    order_date date not null
);
create table OrderItems (
    order_item_id int primary key,
    quantity int not null check ( quantity >= 1 )
);

alter table Orders
add column customer_id int references Customers(customer_id);

alter table OrderItems
add column order_id int references Orders(order_id);
alter table OrderItems
add column product_id int references Products(product_id);