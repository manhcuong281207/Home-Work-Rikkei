set search_path to ss11_g2;

CREATE TABLE accounts (
                          account_id SERIAL PRIMARY KEY,
                          customer_name VARCHAR(100) NOT NULL,
                          balance NUMERIC(12,2) NOT NULL CHECK (balance >= 0)
);
CREATE TABLE transactions (
                              trans_id SERIAL PRIMARY KEY,
                              account_id INT NOT NULL,
                              amount NUMERIC(12,2) NOT NULL CHECK (amount > 0),
                              trans_type VARCHAR(20) NOT NULL CHECK (trans_type IN ('WITHDRAW', 'DEPOSIT')),
                              created_at TIMESTAMP DEFAULT NOW(),

                              CONSTRAINT fk_account
                                  FOREIGN KEY (account_id)
                                      REFERENCES accounts(account_id)
                                      ON DELETE CASCADE
);
INSERT INTO accounts (customer_name, balance)
VALUES
    ('Nguyen Van A', 1000000),
    ('Tran Thi B', 500000),
    ('Le Van C', 2000000);
INSERT INTO transactions (account_id, amount, trans_type)
VALUES
    (1, 200000, 'DEPOSIT'),
    (2, 100000, 'WITHDRAW');

-- Không thể tạo giao dịch cho account không tồn tại
INSERT INTO transactions (account_id, amount, trans_type)
VALUES (999, 100000, 'WITHDRAW');  -- sẽ lỗi FK



BEGIN;
-- 1. Kiểm tra số dư
SELECT balance
FROM accounts
WHERE account_id = 1
    FOR UPDATE;

-- 2. Trừ tiền nếu đủ số dư
UPDATE accounts
SET balance = balance - 200000
WHERE account_id = 1
  AND balance >= 200000;

-- Nếu không có dòng nào bị update => số dư không đủ
-- (trong psql ta kiểm tra bằng cách nhìn row count)

-- 3. Ghi log giao dịch
INSERT INTO transactions (account_id, amount, trans_type)
VALUES (1, 200000, 'WITHDRAW');

COMMIT;



BEGIN;
-- 1. Kiểm tra số dư
SELECT balance
FROM accounts
WHERE account_id = 2
    FOR UPDATE;

-- 2. Trừ tiền
UPDATE accounts
SET balance = balance - 100000
WHERE account_id = 2
  AND balance >= 100000;

INSERT INTO transactions (account_id, amount, trans_type)
VALUES (9999, 100000, 'WITHDRAW');

ROLLBACK;



BEGIN;
-- Khóa dòng tài khoản
SELECT balance
FROM accounts
WHERE account_id = 3
    FOR UPDATE;

-- Kiểm tra đủ tiền
UPDATE accounts
SET balance = balance - 300000
WHERE account_id = 3
  AND balance >= 300000;

-- Nếu không đủ tiền → rollback thủ công
-- (áp dụng trong ứng dụng hoặc DO block)

INSERT INTO transactions (account_id, amount, trans_type)
VALUES (3, 300000, 'WITHDRAW');

COMMIT;
