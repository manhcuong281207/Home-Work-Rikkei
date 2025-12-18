set search_path to ss7_g1;

CREATE TABLE post (
                      post_id SERIAL PRIMARY KEY,
                      user_id INT NOT NULL,
                      content TEXT,
                      tags TEXT[],
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                      is_public BOOLEAN DEFAULT TRUE
);

CREATE TABLE post_like (
                           user_id INT NOT NULL,
                           post_id INT NOT NULL,
                           liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           PRIMARY KEY (user_id, post_id)
);

TRUNCATE TABLE post_like;
TRUNCATE TABLE post RESTART IDENTITY;


INSERT INTO post (user_id, content, tags, created_at, is_public) VALUES
-- Bài công khai, mới, có keyword "du lịch"
(1, 'Kinh nghiệm du lịch Đà Nẵng tự túc', ARRAY['travel', 'vietnam'], NOW() - INTERVAL '1 day', TRUE),

(2, 'Du lịch Hội An 3 ngày 2 đêm', ARRAY['travel', 'culture'], NOW() - INTERVAL '2 days', TRUE),

(3, 'Ẩm thực khi đi du lịch miền Trung', ARRAY['travel', 'food'], NOW() - INTERVAL '3 days', TRUE),

-- Bài công khai nhưng cũ hơn 7 ngày
(4, 'Du lịch châu Âu mùa đông', ARRAY['travel', 'europe'], NOW() - INTERVAL '20 days', TRUE),

-- Bài riêng tư (để test partial index)
(5, 'Kế hoạch du lịch bí mật', ARRAY['travel'], NOW() - INTERVAL '1 day', FALSE),

-- Bài không liên quan du lịch
(6, 'Học PostgreSQL từ cơ bản đến nâng cao', ARRAY['sql', 'database'], NOW() - INTERVAL '2 days', TRUE),

(7, 'Tối ưu truy vấn SQL với index', ARRAY['sql', 'performance'], NOW() - INTERVAL '5 days', TRUE),

-- Bài về food
(8, 'Top món ăn đường phố Sài Gòn', ARRAY['food'], NOW() - INTERVAL '1 day', TRUE),

-- Bài công khai rất mới
(9, 'Trải nghiệm du lịch Phú Quốc', ARRAY['travel', 'island'], NOW() - INTERVAL '3 hours', TRUE),

-- Bài công khai rất cũ
(10, 'Nhật ký du lịch năm 2018', ARRAY['travel'], NOW() - INTERVAL '5 years', TRUE);


INSERT INTO post_like (user_id, post_id, liked_at) VALUES
                                                       (2, 1, NOW()),
                                                       (3, 1, NOW()),
                                                       (4, 2, NOW()),
                                                       (5, 2, NOW()),
                                                       (6, 3, NOW()),
                                                       (1, 6, NOW()),
                                                       (2, 7, NOW()),
                                                       (3, 9, NOW()),
                                                       (4, 9, NOW()),
                                                       (5, 9, NOW());

SET enable_seqscan = OFF;
DROP INDEX idx_gin_content;

CREATE EXTENSION pg_trgm; CREATE EXTENSION btree_gin;
create index idx_gin_content on post using GIN (LOWER(content) gin_trgm_ops);
explain
select * from post where is_public = true and content ilike '%du lịch%';

EXPLAIN ANALYZE
SELECT *
FROM post
WHERE tags @> ARRAY['travel'];

CREATE INDEX idx_post_tags_gin
ON post
USING GIN (tags);


CREATE INDEX idx_post_recent_public
    ON post (created_at DESC)
    WHERE is_public = TRUE;

EXPLAIN ANALYZE
SELECT *
FROM post
WHERE is_public = TRUE
  AND created_at >= NOW() - INTERVAL '7 days';
