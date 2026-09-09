-- Seed thống kê người đăng ký và check-in cho các sự kiện đã kết thúc
-- Chạy file này sau khi đã có users và events.
-- Mục tiêu: tạo dữ liệu thực tế cho báo cáo, thống kê và dashboard.

BEGIN;

-- Dữ liệu tham gia theo 5 user có sẵn trong hệ thống
-- 1) Lấy danh sách user hiện có
-- 2) Gán ngẫu nhiên cho các sự kiện đã kết thúc
-- 3) Một số người đã check-in, một số chưa

WITH users_list AS (
    SELECT id, email, name
    FROM users
    WHERE email IN (
        'lamquocviet2005.nvt@gmail.com',
        'dung.le@example.com',
        'anh.pham@example.com',
        'hoa.nguyen@example.com',
        'minh.tran@example.com'
    )
),
ended_events AS (
    SELECT id, title, start_time, end_time
    FROM events
    WHERE end_time < NOW()
    ORDER BY start_time
),
participant_rows AS (
    SELECT * FROM (
        VALUES
            -- Tech Summit 2026
            ('90d4a9d0-126d-4069-8697-8d85cb12b254', 'lamquocviet2005.nvt@gmail.com', TRUE, '2026-01-15 10:15:00+07', '2026-01-15 09:45:00+07'),
            ('90d4a9d0-126d-4069-8697-8d85cb12b254', 'dung.le@example.com', TRUE, '2026-01-15 10:20:00+07', '2026-01-15 09:50:00+07'),
            ('90d4a9d0-126d-4069-8697-8d85cb12b254', 'anh.pham@example.com', TRUE, '2026-01-15 10:25:00+07', '2026-01-15 10:00:00+07'),
            ('90d4a9d0-126d-4069-8697-8d85cb12b254', 'hoa.nguyen@example.com', FALSE, '2026-01-15 10:30:00+07', NULL),
            ('90d4a9d0-126d-4069-8697-8d85cb12b254', 'minh.tran@example.com', TRUE, '2026-01-15 10:35:00+07', '2026-01-15 09:55:00+07'),

            -- AI & Data Studio Workshop
            ('d8682605-3194-4b36-8fd8-912b6f63a037', 'lamquocviet2005.nvt@gmail.com', TRUE, '2026-02-08 05:45:00+07', '2026-02-08 05:15:00+07'),
            ('d8682605-3194-4b36-8fd8-912b6f63a037', 'dung.le@example.com', TRUE, '2026-02-08 05:50:00+07', '2026-02-08 05:20:00+07'),
            ('d8682605-3194-4b36-8fd8-912b6f63a037', 'anh.pham@example.com', FALSE, '2026-02-08 05:55:00+07', NULL),
            ('d8682605-3194-4b36-8fd8-912b6f63a037', 'hoa.nguyen@example.com', TRUE, '2026-02-08 06:00:00+07', '2026-02-08 05:24:00+07'),

            -- Green Campus Education Expo
            ('9ea26f12-a333-4dba-be6c-429feb31ad91', 'lamquocviet2005.nvt@gmail.com', TRUE, '2026-03-12 09:40:00+07', '2026-03-12 09:10:00+07'),
            ('9ea26f12-a333-4dba-be6c-429feb31ad91', 'dung.le@example.com', TRUE, '2026-03-12 09:45:00+07', '2026-03-12 09:15:00+07'),
            ('9ea26f12-a333-4dba-be6c-429feb31ad91', 'anh.pham@example.com', TRUE, '2026-03-12 09:50:00+07', '2026-03-12 09:18:00+07'),
            ('9ea26f12-a333-4dba-be6c-429feb31ad91', 'hoa.nguyen@example.com', TRUE, '2026-03-12 09:55:00+07', '2026-03-12 09:22:00+07'),
            ('9ea26f12-a333-4dba-be6c-429feb31ad91', 'minh.tran@example.com', FALSE, '2026-03-12 10:00:00+07', NULL),

            -- Hội thảo Đổi mới Giáo dục 4.0
            ('09f936bd-15d2-4c08-acdd-f130a171ed6e', 'lamquocviet2005.nvt@gmail.com', TRUE, '2026-04-05 05:10:00+07', '2026-04-05 04:45:00+07'),
            ('09f936bd-15d2-4c08-acdd-f130a171ed6e', 'dung.le@example.com', TRUE, '2026-04-05 05:15:00+07', '2026-04-05 04:52:00+07'),
            ('09f936bd-15d2-4c08-acdd-f130a171ed6e', 'anh.pham@example.com', FALSE, '2026-04-05 05:18:00+07', NULL),
            ('09f936bd-15d2-4c08-acdd-f130a171ed6e', 'minh.tran@example.com', TRUE, '2026-04-05 05:22:00+07', '2026-04-05 04:57:00+07'),

            -- Hà Nội Marathon 2026
            ('e60fd29f-7a09-4dbc-9dea-2796eb80daeb', 'lamquocviet2005.nvt@gmail.com', TRUE, '2026-05-17 04:40:00+07', '2026-05-17 04:10:00+07'),
            ('e60fd29f-7a09-4dbc-9dea-2796eb80daeb', 'dung.le@example.com', TRUE, '2026-05-17 04:41:00+07', '2026-05-17 04:12:00+07'),
            ('e60fd29f-7a09-4dbc-9dea-2796eb80daeb', 'anh.pham@example.com', TRUE, '2026-05-17 04:42:00+07', '2026-05-17 04:15:00+07'),
            ('e60fd29f-7a09-4dbc-9dea-2796eb80daeb', 'hoa.nguyen@example.com', TRUE, '2026-05-17 04:43:00+07', '2026-05-17 04:18:00+07'),
            ('e60fd29f-7a09-4dbc-9dea-2796eb80daeb', 'minh.tran@example.com', TRUE, '2026-05-17 04:44:00+07', '2026-05-17 04:20:00+07'),

            -- Youth Football League 2026
            ('3cbe60f5-f2ff-4b59-81da-eaf21cc91c12', 'lamquocviet2005.nvt@gmail.com', TRUE, '2026-06-03 13:10:00+07', '2026-06-03 12:50:00+07'),
            ('3cbe60f5-f2ff-4b59-81da-eaf21cc91c12', 'dung.le@example.com', FALSE, '2026-06-03 13:15:00+07', NULL),
            ('3cbe60f5-f2ff-4b59-81da-eaf21cc91c12', 'anh.pham@example.com', TRUE, '2026-06-03 13:20:00+07', '2026-06-03 12:52:00+07'),
            ('3cbe60f5-f2ff-4b59-81da-eaf21cc91c12', 'hoa.nguyen@example.com', TRUE, '2026-06-03 13:25:00+07', '2026-06-03 12:54:00+07'),

            -- Đêm nhạc Indie Mùa Hè
            ('79e01660-9510-40bf-a67f-72b1137aef25', 'lamquocviet2005.nvt@gmail.com', TRUE, '2026-07-12 16:10:00+07', '2026-07-12 15:30:00+07'),
            ('79e01660-9510-40bf-a67f-72b1137aef25', 'dung.le@example.com', TRUE, '2026-07-12 16:15:00+07', '2026-07-12 15:35:00+07'),
            ('79e01660-9510-40bf-a67f-72b1137aef25', 'anh.pham@example.com', FALSE, '2026-07-12 16:20:00+07', NULL),
            ('79e01660-9510-40bf-a67f-72b1137aef25', 'minh.tran@example.com', TRUE, '2026-07-12 16:25:00+07', '2026-07-12 15:38:00+07'),

            -- Jazz & Soul Night
            ('a4452de2-5612-4541-b6ae-e2ea5e2e2cde', 'lamquocviet2005.nvt@gmail.com', TRUE, '2026-08-09 16:40:00+07', '2026-08-09 16:10:00+07'),
            ('a4452de2-5612-4541-b6ae-e2ea5e2e2cde', 'dung.le@example.com', TRUE, '2026-08-09 16:45:00+07', '2026-08-09 16:15:00+07'),
            ('a4452de2-5612-4541-b6ae-e2ea5e2e2cde', 'anh.pham@example.com', TRUE, '2026-08-09 16:50:00+07', '2026-08-09 16:18:00+07'),
            ('a4452de2-5612-4541-b6ae-e2ea5e2e2cde', 'hoa.nguyen@example.com', FALSE, '2026-08-09 16:55:00+07', NULL),

            -- Đại hội Cộng đồng Trẻ Hà Nội
            ('3e7b368b-3b46-49ea-a882-8ff64c354fc2', 'lamquocviet2005.nvt@gmail.com', TRUE, '2026-10-04 10:20:00+07', '2026-10-04 09:50:00+07'),
            ('3e7b368b-3b46-49ea-a882-8ff64c354fc2', 'dung.le@example.com', TRUE, '2026-10-04 10:25:00+07', '2026-10-04 09:52:00+07'),
            ('3e7b368b-3b46-49ea-a882-8ff64c354fc2', 'anh.pham@example.com', TRUE, '2026-10-04 10:30:00+07', '2026-10-04 09:55:00+07'),
            ('3e7b368b-3b46-49ea-a882-8ff64c354fc2', 'hoa.nguyen@example.com', TRUE, '2026-10-04 10:35:00+07', '2026-10-04 09:58:00+07'),
            ('3e7b368b-3b46-49ea-a882-8ff64c354fc2', 'minh.tran@example.com', FALSE, '2026-10-04 10:40:00+07', NULL),

            -- Volunteer Cleanup Day
            ('26be65cf-57a2-42dc-a20f-332a55698e3c', 'lamquocviet2005.nvt@gmail.com', TRUE, '2026-10-20 05:10:00+07', '2026-10-20 04:40:00+07'),
            ('26be65cf-57a2-42dc-a20f-332a55698e3c', 'dung.le@example.com', TRUE, '2026-10-20 05:12:00+07', '2026-10-20 04:45:00+07'),
            ('26be65cf-57a2-42dc-a20f-332a55698e3c', 'anh.pham@example.com', TRUE, '2026-10-20 05:15:00+07', '2026-10-20 04:48:00+07'),

            -- Festival ánh sáng & âm nhạc
            ('485ac913-c815-4f4e-a479-5ebe976aada3', 'lamquocviet2005.nvt@gmail.com', TRUE, '2026-11-03 15:40:00+07', '2026-11-03 15:00:00+07'),
            ('485ac913-c815-4f4e-a479-5ebe976aada3', 'dung.le@example.com', TRUE, '2026-11-03 15:45:00+07', '2026-11-03 15:05:00+07'),
            ('485ac913-c815-4f4e-a479-5ebe976aada3', 'anh.pham@example.com', FALSE, '2026-11-03 15:50:00+07', NULL),
            ('485ac913-c815-4f4e-a479-5ebe976aada3', 'hoa.nguyen@example.com', TRUE, '2026-11-03 15:55:00+07', '2026-11-03 15:08:00+07'),

            -- Hội nghị AI cho Doanh nghiệp
            ('1b4102b4-894f-477d-a135-d63df06994ab', 'lamquocviet2005.nvt@gmail.com', TRUE, '2026-11-21 09:10:00+07', '2026-11-21 08:40:00+07'),
            ('1b4102b4-894f-477d-a135-d63df06994ab', 'dung.le@example.com', TRUE, '2026-11-21 09:15:00+07', '2026-11-21 08:42:00+07'),
            ('1b4102b4-894f-477d-a135-d63df06994ab', 'anh.pham@example.com', TRUE, '2026-11-21 09:18:00+07', '2026-11-21 08:44:00+07'),
            ('1b4102b4-894f-477d-a135-d63df06994ab', 'minh.tran@example.com', TRUE, '2026-11-21 09:20:00+07', '2026-11-21 08:48:00+07'),

            -- Festival Thanh niên sáng tạo
            ('8960d8ac-ca4f-450c-964c-c00e0457639c', 'lamquocviet2005.nvt@gmail.com', TRUE, '2026-12-05 11:40:00+07', '2026-12-05 11:00:00+07'),
            ('8960d8ac-ca4f-450c-964c-c00e0457639c', 'dung.le@example.com', TRUE, '2026-12-05 11:45:00+07', '2026-12-05 11:05:00+07'),
            ('8960d8ac-ca4f-450c-964c-c00e0457639c', 'hoa.nguyen@example.com', FALSE, '2026-12-05 11:35:00+07', NULL),
            ('8960d8ac-ca4f-450c-964c-c00e0457639c', 'anh.pham@example.com', TRUE, '2026-12-05 11:50:00+07', '2026-12-05 11:10:00+07'),

            -- STEM For Kids 2026
            ('bfb6df9f-13f2-4094-953b-f749163ae44f', 'lamquocviet2005.nvt@gmail.com', TRUE, '2026-12-12 05:35:00+07', '2026-12-12 05:10:00+07'),
            ('bfb6df9f-13f2-4094-953b-f749163ae44f', 'dung.le@example.com', TRUE, '2026-12-12 05:40:00+07', '2026-12-12 05:12:00+07'),
            ('bfb6df9f-13f2-4094-953b-f749163ae44f', 'hoa.nguyen@example.com', TRUE, '2026-12-12 05:45:00+07', '2026-12-12 05:15:00+07')
    ) AS v(event_id, email, checked_in, joined_at, check_in_time)
),
insert_rows AS (
    INSERT INTO participants (user_id, event_id, qr_code, joined_at, checked_in, check_in_time)
    SELECT u.id,
           pr.event_id::uuid,
           concat('qr-', u.id::text, '-', pr.event_id::text),
           pr.joined_at::timestamptz,
           pr.checked_in,
           pr.check_in_time::timestamptz
    FROM participant_rows pr
    JOIN users_list u ON u.email = pr.email
    ON CONFLICT (user_id, event_id) DO NOTHING
    RETURNING event_id, user_id, checked_in
)
SELECT 1;

-- Cập nhật events_attended cho user khi họ có check_in = true
UPDATE users u
SET events_attended = (
    SELECT COUNT(*)
    FROM participants p
    WHERE p.user_id = u.id
      AND p.checked_in = TRUE
)
WHERE u.email IN (
    'lamquocviet2005.nvt@gmail.com',
    'dung.le@example.com',
    'anh.pham@example.com',
    'hoa.nguyen@example.com',
    'minh.tran@example.com'
);

COMMIT;
