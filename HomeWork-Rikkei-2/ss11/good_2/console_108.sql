set search_path to ss11_k2;

CREATE TABLE accounts (
                          account_id SERIAL PRIMARY KEY,
                          owner_name VARCHAR(100),
                          balance NUMERIC(10,2)
);

INSERT INTO accounts (owner_name, balance)
VALUES ('A', 500.00), ('B', 300.00);

begin;
update accounts set balance = balance - 100.00 where account_id = 1;
update accounts set balance = balance + 100.00 where account_id = 2;
commit;
