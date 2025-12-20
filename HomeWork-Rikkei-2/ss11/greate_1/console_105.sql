set search_path to ss11_k1;

CREATE TABLE flights (
                         flight_id SERIAL PRIMARY KEY,
                         flight_name VARCHAR(100),
                         available_seats INT
);

CREATE TABLE bookings (
                          booking_id SERIAL PRIMARY KEY,
                          flight_id INT REFERENCES flights(flight_id),
                          customer_name VARCHAR(100)
);

INSERT INTO flights (flight_name, available_seats)
VALUES ('VN123', 3), ('VN456', 2);

create or replace procedure book_flight_v1(p_flight_id int, p_customer_name varchar(50))
language plpgsql as $$
    declare available_seats_var int;
    begin
        select available_seats into available_seats_var
        from flights
        where flight_id = p_flight_id
        for update;

        if available_seats_var <= 0 then
            rollback;
            raise notice 'hết chỗ';
            return;
        end if;

        insert into bookings(flight_id, customer_name)
        values (p_flight_id, p_customer_name);
        update flights
        set available_seats = available_seats - 1
        where flight_id = p_flight_id;
        commit;
    end;
$$;

call book_flight_v1(2, 'hello2');

