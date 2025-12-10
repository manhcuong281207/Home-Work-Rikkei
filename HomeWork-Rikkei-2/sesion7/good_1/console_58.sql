set search_path to ss7_k1;

CREATE TABLE book (
                      book_id SERIAL PRIMARY KEY,
                      title VARCHAR(255),
                      author VARCHAR(100),
                      genre VARCHAR(50),
                      price DECIMAL(10,2),
                      description TEXT,
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO book (title, author, genre, price, description) VALUES
                                                                ('Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 'Fantasy', 12.99, 'First book of the Harry Potter series'),
                                                                ('Harry Potter and the Chamber of Secrets', 'J.K. Rowling', 'Fantasy', 13.99, 'Second book of the Harry Potter series'),
                                                                ('Harry Potter and the Prisoner of Azkaban', 'J.K. Rowling', 'Fantasy', 15.50, 'Third Harry Potter book'),
                                                                ('Fantastic Beasts', 'J.K. Rowling', 'Fantasy', 11.99, 'Wizarding World expansion'),
                                                                ('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 10.50, 'Adventure of Bilbo Baggins'),
                                                                ('The Lord of the Rings: Fellowship', 'J.R.R. Tolkien', 'Fantasy', 14.80, 'Epic fantasy novel'),
                                                                ('The Lord of the Rings: Two Towers', 'J.R.R. Tolkien', 'Fantasy', 14.90, 'Sequel in LOTR trilogy'),
                                                                ('The Lord of the Rings: Return of the King', 'J.R.R. Tolkien', 'Fantasy', 15.99, 'Final book in LOTR'),
                                                                ('Eragon', 'Christopher Paolini', 'Fantasy', 9.99, 'Dragon rider story'),
                                                                ('Eldest', 'Christopher Paolini', 'Fantasy', 10.99, 'Book 2 of Eragon series'),

                                                                ('A Game of Thrones', 'George R.R. Martin', 'Fantasy', 13.99, 'Book 1 of A Song of Ice and Fire'),
                                                                ('A Clash of Kings', 'George R.R. Martin', 'Fantasy', 14.99, 'Book 2 of ASOIAF'),
                                                                ('A Storm of Swords', 'George R.R. Martin', 'Fantasy', 15.99, 'Book 3 of ASOIAF'),
                                                                ('A Feast for Crows', 'George R.R. Martin', 'Fantasy', 13.50, 'Book 4 ASOIAF'),
                                                                ('A Dance with Dragons', 'George R.R. Martin', 'Fantasy', 16.99, 'Book 5 ASOIAF'),

                                                                ('The Shining', 'Stephen King', 'Horror', 11.50, 'Classic horror novel'),
                                                                ('It', 'Stephen King', 'Horror', 12.50, 'Killer clown horror'),
                                                                ('Carrie', 'Stephen King', 'Horror', 10.50, 'Telekinetic girl'),
                                                                ('Misery', 'Stephen King', 'Horror', 9.99, 'Kidnapped author horror'),
                                                                ('Pet Sematary', 'Stephen King', 'Horror', 11.20, 'Cursed burial ground story'),

                                                                ('Pride and Prejudice', 'Jane Austen', 'Romance', 8.99, 'Classic romance novel'),
                                                                ('Emma', 'Jane Austen', 'Romance', 9.50, 'Story of matchmaking'),
                                                                ('Sense and Sensibility', 'Jane Austen', 'Romance', 7.99, 'Love and heartbreak'),
                                                                ('Wuthering Heights', 'Emily Brontë', 'Romance', 8.99, 'Dark romance tale'),
                                                                ('Jane Eyre', 'Charlotte Brontë', 'Romance', 9.99, 'Governess love story'),

                                                                ('Dune', 'Frank Herbert', 'Science Fiction', 14.50, 'Sci-fi desert epic'),
                                                                ('Dune Messiah', 'Frank Herbert', 'Science Fiction', 13.50, 'Sequel to Dune'),
                                                                ('Children of Dune', 'Frank Herbert', 'Science Fiction', 14.00, 'Book 3 of Dune'),
                                                                ('1984', 'George Orwell', 'Science Fiction', 10.50, 'Dystopian society'),
                                                                ('Brave New World', 'Aldous Huxley', 'Science Fiction', 9.99, 'Genetic dystopia'),

                                                                ('The Martian', 'Andy Weir', 'Science Fiction', 12.99, 'Astronaut survival'),
                                                                ('Project Hail Mary', 'Andy Weir', 'Science Fiction', 14.99, 'Alien contact mission'),
                                                                ('Ready Player One', 'Ernest Cline', 'Science Fiction', 11.99, 'Virtual reality adventure'),
                                                                ('Neuromancer', 'William Gibson', 'Science Fiction', 10.99, 'Cyberpunk classic'),
                                                                ('Foundation', 'Isaac Asimov', 'Science Fiction', 12.50, 'Psychohistory epic'),

                                                                ('Sherlock Holmes: Study in Scarlet', 'Arthur Conan Doyle', 'Mystery', 8.99, 'First Sherlock story'),
                                                                ('Sherlock Holmes: Hound of Baskervilles', 'Arthur Conan Doyle', 'Mystery', 9.50, 'Famous Holmes mystery'),
                                                                ('Murder on the Orient Express', 'Agatha Christie', 'Mystery', 10.50, 'Poirot investigates'),
                                                                ('Death on the Nile', 'Agatha Christie', 'Mystery', 11.00, 'Egypt murder case'),
                                                                ('Gone Girl', 'Gillian Flynn', 'Mystery', 12.99, 'Modern thriller'),

                                                                ('The Alchemist', 'Paulo Coelho', 'Philosophy', 9.99, 'Spiritual journey'),
                                                                ('Man’s Search for Meaning', 'Viktor Frankl', 'Philosophy', 11.50, 'Holocaust psychology'),
                                                                ('Meditations', 'Marcus Aurelius', 'Philosophy', 8.50, 'Stoic philosophy'),
                                                                ('Beyond Good and Evil', 'Friedrich Nietzsche', 'Philosophy', 9.50, 'Christianity critique'),
                                                                ('Republic', 'Plato', 'Philosophy', 10.99, 'Political philosophy'),

                                                                ('Atomic Habits', 'James Clear', 'Self-help', 12.99, 'Habit-building guide'),
                                                                ('The Power of Habit', 'Charles Duhigg', 'Self-help', 11.50, 'Behavioral psychology'),
                                                                ('How to Win Friends', 'Dale Carnegie', 'Self-help', 10.30, 'Social skills training'),
                                                                ('Deep Work', 'Cal Newport', 'Self-help', 12.00, 'Focus training'),
                                                                ('The Subtle Art of Not Giving a F*ck', 'Mark Manson', 'Self-help', 13.20, 'Life advice'),

                                                                ('Sapiens', 'Yuval Noah Harari', 'History', 15.99, 'Human evolution'),
                                                                ('Homo Deus', 'Yuval Noah Harari', 'History', 16.50, 'Future of humanity'),
                                                                ('21 Lessons for the 21st Century', 'Yuval Noah Harari', 'History', 14.00, 'Modern issues'),
                                                                ('Guns, Germs, and Steel', 'Jared Diamond', 'History', 13.99, 'Civilization development'),
                                                                ('The Silk Roads', 'Peter Frankopan', 'History', 12.99, 'Global history'),

-- 50 MORE RANDOMIZED BOOKS TO REACH 100
                                                                ('The Ocean at the End of the Lane', 'Neil Gaiman', 'Fantasy', 10.99, 'Fantasy mystery'),
                                                                ('Coraline', 'Neil Gaiman', 'Fantasy', 8.99, 'Dark children fantasy'),
                                                                ('American Gods', 'Neil Gaiman', 'Fantasy', 11.99, 'Mythology adventure'),
                                                                ('Good Omens', 'Neil Gaiman', 'Fantasy', 10.99, 'Comedy apocalypse'),
                                                                ('The Graveyard Book', 'Neil Gaiman', 'Fantasy', 9.99, 'Ghost child story'),

                                                                ('The Stand', 'Stephen King', 'Horror', 14.50, 'Post-apocalyptic horror'),
                                                                ('Doctor Sleep', 'Stephen King', 'Horror', 13.50, 'Sequel to The Shining'),
                                                                ('Salem''s Lot', 'Stephen King', 'Horror', 12.20, 'Vampire story'),
                                                                ('The Outsider', 'Stephen King', 'Horror', 11.99, 'Detective horror'),
                                                                ('The Institute', 'Stephen King', 'Horror', 13.00, 'Kid psychic horror'),

                                                                ('Norwegian Wood', 'Haruki Murakami', 'Romance', 11.99, 'Japanese love story'),
                                                                ('Kafka on the Shore', 'Haruki Murakami', 'Fantasy', 12.50, 'Surreal fantasy'),
                                                                ('1Q84', 'Haruki Murakami', 'Fantasy', 13.50, 'Parallel world'),
                                                                ('Colorless Tsukuru Tazaki', 'Haruki Murakami', 'Mystery', 10.99, 'Mystery novel'),
                                                                ('The Wind-Up Bird Chronicle', 'Haruki Murakami', 'Mystery', 12.99, 'Detective mystery'),

                                                                ('Martian Chronicles', 'Ray Bradbury', 'Science Fiction', 10.50, 'Mars colonization'),
                                                                ('Fahrenheit 451', 'Ray Bradbury', 'Science Fiction', 9.99, 'Book burning dystopia'),
                                                                ('Something Wicked', 'Ray Bradbury', 'Horror', 11.00, 'Dark carnival'),
                                                                ('The Illustrated Man', 'Ray Bradbury', 'Fantasy', 10.20, 'Short stories'),
                                                                ('Dandelion Wine', 'Ray Bradbury', 'Fantasy', 8.50, 'Childhood nostalgia'),

                                                                ('Zero to One', 'Peter Thiel', 'Business', 12.99, 'Startup strategy'),
                                                                ('The Lean Startup', 'Eric Ries', 'Business', 13.50, 'Startup methodology'),
                                                                ('Principles', 'Ray Dalio', 'Business', 16.00, 'Work principles'),
                                                                ('Rich Dad Poor Dad', 'Robert Kiyosaki', 'Business', 10.99, 'Finance basics'),
                                                                ('The Intelligent Investor', 'Benjamin Graham', 'Business', 14.99, 'Investment bible'),

                                                                ('The 48 Laws of Power', 'Robert Greene', 'Self-help', 14.50, 'Power dynamics'),
                                                                ('Mastery', 'Robert Greene', 'Self-help', 13.50, 'Skill mastery'),
                                                                ('The Art of War', 'Sun Tzu', 'Philosophy', 9.99, 'War strategy'),
                                                                ('Thus Spoke Zarathustra', 'Friedrich Nietzsche', 'Philosophy', 11.99, 'Existential philosophy'),
                                                                ('Crime and Punishment', 'Fyodor Dostoevsky', 'Mystery', 12.50, 'Psychological crime'),

                                                                ('Frankenstein', 'Mary Shelley', 'Horror', 10.99, 'Classic monster novel'),
                                                                ('Dracula', 'Bram Stoker', 'Horror', 9.99, 'Vampire origin novel'),
                                                                ('The Time Machine', 'H.G. Wells', 'Science Fiction', 8.99, 'Sci-fi time travel'),
                                                                ('The Invisible Man', 'H.G. Wells', 'Science Fiction', 9.50, 'Science-fiction mystery'),
                                                                ('War of the Worlds', 'H.G. Wells', 'Science Fiction', 10.50, 'Alien invasion');

CREATE EXTENSION IF NOT EXISTS pg_trgm;


-- So sánh thời gian truy vấn trước và sau khi tạo Index (dùng EXPLAIN ANALYZE)
CREATE INDEX idx_book_author ON book(author);
EXPLAIN ANALYZE
select * from book where author ilike '%Rowling%';

CREATE INDEX idx_book_genre ON book(genre);
EXPLAIN ANALYZE
select * from book where genre ilike 'Fantasy';

-- Thử nghiệm các loại chỉ mục khác nhau:
-- B-tree cho genre
-- GIN cho title hoặc description (phục vụ tìm kiếm full-text)
CREATE INDEX idx_book_title_gin ON book USING GIN (title gin_trgm_ops);
DROP INDEX idx_book_title_gin;

EXPLAIN ANALYZE
SELECT * FROM book WHERE title ILIKE '%magic%';

-- Tạo một Clustered Index (sử dụng lệnh CLUSTER) trên bảng book theo cột genre và kiểm tra sự khác biệt trong hiệu suất
CLUSTER book USING idx_book_genre;
ANALYZE book;

EXPLAIN ANALYZE
SELECT * FROM book WHERE genre = 'Fantasy';


-- Viết báo cáo ngắn (5-7 dòng) giải thích:
-- Loại chỉ mục nào hiệu quả nhất cho từng loại truy vấn?
-- Khi nào Hash index không được khuyến khích trong PostgreSQL?