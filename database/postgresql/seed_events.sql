-- Seed events mẫu cho hệ thống quản lý sự kiện (Đã bổ sung image_url)
-- Chạy file này sau khi schema đã được tạo.
-- Tương thích PostgreSQL, an toàn khi chạy nhiều lần.

BEGIN;

-- Tạo các danh mục bắt buộc nếu chưa tồn tại
INSERT INTO categories (name, description, color, icon)
VALUES
    ('Công nghệ', 'Sự kiện về công nghệ, AI, phần mềm và đổi mới sáng tạo', '#3B82F6', 'laptop'),
    ('Giáo dục', 'Học tập, đào tạo và triển khai chương trình giáo dục', '#10B981', 'book-open'),
    ('Thể thao', 'Các hoạt động thể thao, vận động và phong trào cộng đồng', '#F59E0B', 'dumbbell'),
    ('Âm nhạc', 'Concert, nhạc sống, festival âm nhạc và nghệ sĩ', '#8B5CF6', 'music'),
    ('Hội thảo', 'Hội thảo chuyên môn, chia sẻ kinh nghiệm và networking', '#F97316', 'presentation'),
    ('Giải trí', 'Show diễn, sự kiện vui chơi, giải trí cộng đồng', '#EC4899', 'sparkles'),
    ('Cộng đồng', 'Sự kiện thiện nguyện, kết nối cộng đồng và hoạt động xã hội', '#22C55E', 'users')
ON CONFLICT (name) DO NOTHING;

-- Dữ liệu sự kiện mẫu
WITH event_rows AS (
    SELECT * FROM (
        VALUES
            (
                'Tech Summit 2026',
                'Hội nghị công nghệ quy mô lớn với các chủ đề AI, dữ liệu, bảo mật và chuyển đổi số cho doanh nghiệp Việt Nam.',
                '2026-01-15 09:00:00+07',
                '2026-01-15 17:00:00+07',
                'Trung tâm Hội nghị Vincom Center B, Hà Nội',
                'https://images.unsplash.com/photo-1540575467063-178a50c2df87?q=80&w=1000&auto=format&fit=crop',
                TRUE,
                500,
                'lamquocviet2005.nvt@gmail.com',
                'Công nghệ',
                'approved'
            ),
            (
                'AI & Data Studio Workshop',
                'Workshop thực hành xây dựng mô hình AI, phân tích dữ liệu và ứng dụng vào doanh nghiệp ở mức doanh nghiệp vừa và nhỏ.',
                '2026-02-08 09:30:00+07',
                '2026-02-08 12:30:00+07',
                'Phòng Lab 4, Đại học Bách Khoa Hà Nội',
                'https://images.unsplash.com/photo-1531482615713-2afd69097998?q=80&w=1000&auto=format&fit=crop',
                TRUE,
                180,
                'anh.pham@example.com',
                'Công nghệ',
                'approved'
            ),
            (
                'Green Campus Education Expo',
                'Triển lãm giáo dục bền vững, giới thiệu chương trình học tiên tiến và cơ hội học tập cho học sinh, sinh viên.',
                '2026-03-12 08:30:00+07',
                '2026-03-12 16:30:00+07',
                'Sảnh chính Trường Đại học Sư phạm Hà Nội',
                'https://images.unsplash.com/photo-1523240795612-9a054b0db644?q=80&w=1000&auto=format&fit=crop',
                TRUE,
                350,
                'hoa.nguyen@example.com',
                'Giáo dục',
                'approved'
            ),
            (
                'Hội thảo Đổi mới Giáo dục 4.0',
                'Hội thảo chuyên sâu về đổi mới trong giảng dạy, công nghệ hỗ trợ học tập và mô hình giáo dục tương lai.',
                '2026-04-05 09:00:00+07',
                '2026-04-05 12:00:00+07',
                'Phòng 302, Tòa nhà Khoa học Xã hội, Hà Nội',
                'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?q=80&w=1000&auto=format&fit=crop',
                TRUE,
                220,
                'minh.tran@example.com',
                'Hội thảo',
                'approved'
            ),
            (
                'Hà Nội Marathon 2026',
                'Giải chạy bộ cộng đồng quy mô lớn, khuyến khích phong trào rèn luyện sức khỏe và lan tỏa tinh thần thể thao.',
                '2026-05-17 06:00:00+07',
                '2026-05-17 11:30:00+07',
                'Quảng trường Hoàn Kiếm, Hà Nội',
                'https://images.unsplash.com/photo-1452626038306-9aae5e071dd3?q=80&w=1000&auto=format&fit=crop',
                TRUE,
                1200,
                'dung.le@example.com',
                'Thể thao',
                'approved'
            ),
            (
                'Youth Football League 2026',
                'Giải bóng đá thanh niên, kết nối các đội bóng địa phương và tạo sân chơi lành mạnh cho giới trẻ.',
                '2026-06-03 16:00:00+07',
                '2026-06-03 20:00:00+07',
                'Sân vận động Mỹ Đình, Hà Nội',
                'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?q=80&w=1000&auto=format&fit=crop',
                TRUE,
                400,
                'lamquocviet2005.nvt@gmail.com',
                'Thể thao',
                'approved'
            ),
            (
                'Đêm nhạc Indie Mùa Hè',
                'Buổi trình diễn âm nhạc indie, rock và acoustic với các ca sĩ trẻ và ban nhạc địa phương.',
                '2026-07-12 19:30:00+07',
                '2026-07-12 23:00:00+07',
                'Sân khấu ngoài trời, Công viên Cầu Giấy, Hà Nội',
                'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?q=80&w=1000&auto=format&fit=crop',
                TRUE,
                800,
                'anh.pham@example.com',
                'Âm nhạc',
                'approved'
            ),
            (
                'Jazz & Soul Night',
                'Đêm nhạc jazz và soul được tổ chức với các nghệ sĩ biểu diễn trực tiếp trong không khí ấm cúng và sáng tạo.',
                '2026-08-09 20:00:00+07',
                '2026-08-09 23:30:00+07',
                'Nhà hát Thanh Niên, Hà Nội',
                'https://images.unsplash.com/photo-1511192336575-5a79af67a629?q=80&w=1000&auto=format&fit=crop',
                TRUE,
                300,
                'hoa.nguyen@example.com',
                'Âm nhạc',
                'approved'
            ),
            (
                'Startup Pitching Day 2026',
                'Ngày gọi vốn và gặp gỡ nhà đầu tư cho các startup trong lĩnh vực công nghệ, fintech và AI.',
                '2026-09-18 13:30:00+07',
                '2026-09-18 18:00:00+07',
                'Khách sạn Pan Pacific, Hà Nội',
                'https://images.unsplash.com/photo-1475721027785-f74eccf877e2?q=80&w=1000&auto=format&fit=crop',
                TRUE,
                250,
                'minh.tran@example.com',
                'Hội thảo',
                'approved'
            ),
            (
                'Đại hội Cộng đồng Trẻ Hà Nội',
                'Sự kiện kết nối, giao lưu và lan tỏa tinh thần hoạt động cộng đồng cho giới trẻ thành phố.',
                '2026-10-04 09:00:00+07',
                '2026-10-04 17:00:00+07',
                'Công viên Thống Nhất, Hà Nội',
                'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?q=80&w=1000&auto=format&fit=crop',
                TRUE,
                600,
                'dung.le@example.com',
                'Cộng đồng',
                'approved'
            ),
            (
                'Volunteer Cleanup Day',
                'Ngày tình nguyện dọn dẹp môi trường, bảo vệ cảnh quan và nâng cao ý thức cộng đồng.',
                '2026-10-20 08:00:00+07',
                '2026-10-20 12:00:00+07',
                'Khu đô thị Nam An Khánh, Hà Nội',
                'https://images.unsplash.com/photo-1618477461853-cf6ed80faba5?q=80&w=1000&auto=format&fit=crop',
                TRUE,
                200,
                'lamquocviet2005.nvt@gmail.com',
                'Cộng đồng',
                'approved'
            ),
            (
                'Festival ánh sáng & âm nhạc',
                'Lễ hội ánh sáng quy mô lớn kết hợp âm nhạc, nghệ thuật tương tác và không gian trải nghiệm sáng tạo.',
                '2026-11-03 18:30:00+07',
                '2026-11-03 22:30:00+07',
                'Công viên Lê Văn Tám, Đà Nẵng',
                'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1000&auto=format&fit=crop',
                TRUE,
                900,
                'anh.pham@example.com',
                'Giải trí',
                'approved'
            ),
            (
                'Hội nghị AI cho Doanh nghiệp',
                'Hội nghị chuyên sâu về ứng dụng AI trong vận hành, marketing và quản trị doanh nghiệp hiện đại.',
                '2026-11-21 09:00:00+07',
                '2026-11-21 16:00:00+07',
                'Trung tâm Hội nghị Quốc tế, TP.HCM',
                'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?q=80&w=1000&auto=format&fit=crop',
                TRUE,
                450,
                'hoa.nguyen@example.com',
                'Hội thảo',
                'approved'
            ),
            (
                'Festival Thanh niên sáng tạo',
                'Sự kiện nghệ thuật, công nghệ và sáng tạo dành cho thanh niên, với nhiều hoạt động trải nghiệm tương tác.',
                '2026-12-05 09:30:00+07',
                '2026-12-05 18:30:00+07',
                'Khu đô thị mới Đà Lạt',
                'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?q=80&w=1000&auto=format&fit=crop',
                TRUE,
                600,
                'minh.tran@example.com',
                'Giải trí',
                'approved'
            ),
            (
                'STEM For Kids 2026',
                'Chương trình STEM dành cho trẻ em với các hoạt động khoa học, công nghệ, kỹ thuật và toán học tương tác.',
                '2026-12-12 08:30:00+07',
                '2026-12-12 12:30:00+07',
                'Trung tâm Giáo dục Quốc tế, Hà Nội',
                'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?q=80&w=1000&auto=format&fit=crop',
                TRUE,
                240,
                'dung.le@example.com',
                'Giáo dục',
                'approved'
            )
    ) AS v(title, description, start_time, end_time, location, image_url, is_public, max_participants, created_by_email, category_name, status)
),
admin_lookup AS (
    SELECT id AS created_by, email
    FROM users
    WHERE email IN (SELECT DISTINCT created_by_email FROM event_rows)
),
category_lookup AS (
    SELECT id AS category_id, name
    FROM categories
    WHERE name IN (SELECT DISTINCT category_name FROM event_rows)
)
INSERT INTO events (
    title,
    description,
    start_time,
    end_time,
    location,
    image_url,
    is_public,
    max_participants,
    created_by,
    category_id,
    status
)
SELECT
    er.title,
    er.description,
    er.start_time::timestamptz,
    er.end_time::timestamptz,
    er.location,
    er.image_url,
    er.is_public,
    er.max_participants,
    al.created_by,
    cl.category_id,
    er.status
FROM event_rows er
JOIN admin_lookup al ON al.email = er.created_by_email
JOIN category_lookup cl ON cl.name = er.category_name
WHERE NOT EXISTS (
    SELECT 1
    FROM events e
    WHERE e.title = er.title
);

COMMIT;