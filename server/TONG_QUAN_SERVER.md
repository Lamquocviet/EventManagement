# Tổng quan Server và cách lưu trữ Database

## 1. Mục tiêu của server

Server của dự án được xây dựng bằng Node.js + Express, đóng vai trò là backend API cho hệ thống quản lý sự kiện. Nó nhận các request từ client, xác thực người dùng, xử lý nghiệp vụ sự kiện, điểm danh, đánh giá, thông báo và thống kê.

Cấu trúc bắt đầu từ file [server/src/app.js](src/app.js), nơi server khởi tạo:

- Express app
- CORS để cho phép client truy cập
- Middleware xác thực, rate limiting, ghi log
- Các route chính của hệ thống
- Kết nối tới cơ sở dữ liệu và Redis
- Khởi chạy server trên port 5000

---

## 2. Các chức năng chính của server

### 2.1. Xác thực và phân quyền

Được xử lý qua các route và middleware như:

- `authRoutes.js`
- `authMiddleware.js`
- `roleMiddleware.js`
- `validateMiddleware.js`

Chức năng gồm:

- Đăng ký tài khoản
- Đăng nhập
- Xác thực JWT
- Phân quyền theo vai trò như: `user`, `moderator`, `admin`
- Kiểm tra quyền truy cập vào các API riêng

Tính năng này bảo đảm người dùng chỉ được phép thao tác trên dữ liệu phù hợp với vai trò của mình.

### 2.2. Quản lý người dùng

Các API liên quan đến người dùng nằm trong:

- `userRoutes.js`
- `userController.js`
- `User.js`

Chức năng chính:

- Xem hồ sơ cá nhân
- Cập nhật thông tin cá nhân
- Đổi mật khẩu
- Quản lý trạng thái khóa tài khoản
- Xem thống kê người dùng
- Quản lý tài khoản cho admin

### 2.3. Quản lý sự kiện

Các file chính:

- `eventRoutes.js`
- `eventController.js`
- `Event.js`

Chức năng chính:

- Tạo sự kiện mới
- Xem danh sách sự kiện
- Xem chi tiết sự kiện
- Cập nhật sự kiện
- Duyệt hoặc từ chối sự kiện
- Hủy sự kiện
- Xem thống kê sự kiện
- Kiểm tra quyền chỉnh sửa/xóa sự kiện

Đây là phần cốt lõi của hệ thống vì hầu hết API khác đều liên quan đến sự kiện như tham gia, điểm danh, đánh giá, bình luận.

### 2.4. Điểm danh QR

Được xử lý qua:

- `attendanceRoutes.js`
- `attendanceController.js`
- `Attendance.js`
- `qrGenerator.js`

Chức năng:

- Tạo mã QR cho sự kiện hoặc người tham gia
- Người dùng quét QR để check-in
- Ghi nhận thời gian tham gia
- Lấy danh sách người tham gia đã check-in
- Theo dõi trạng thái tham gia sự kiện

### 2.5. Bình luận và đánh giá

Các file:

- `commentRoutes.js`, `commentController.js`, `Comment.js`
- `reviewRoutes.js`, `reviewController.js`, `Review.js`

Chức năng:

- Thêm bình luận cho sự kiện
- Trả lời bình luận
- Xem comment theo sự kiện
- Thêm đánh giá sao
- Lưu nhận xét của người dùng
- Tính toán đánh giá trung bình cho event

### 2.6. Thống kê và báo cáo

Các file:

- `statsRoutes.js`
- `statsController.js`
- `statistics.js`

Chức năng:

- Thống kê số lượng người dùng
- Thống kê số lượng sự kiện
- Thống kê tham gia sự kiện
- Thống kê đánh giá, lượt tương tác
- Tạo báo cáo cho admin/moderator

### 2.7. Email và xác thực email

Các file:

- `emailRoutes.js`
- `emailVerificationController.js`
- `emailService.js`

Chức năng:

- Gửi email xác thực tài khoản
- Gửi mã OTP hoặc link xác nhận
- Gửi thông báo tới người dùng

### 2.8. Thông báo và phiên làm việc

Các file:

- `notifications.js`
- `notificationController.js`
- `Notification.js`
- `sessions.js`
- `sessionController.js`

Chức năng:

- Gửi thông báo cho người dùng
- Lưu lịch sử thông báo
- Quản lý phiên đăng nhập / session
- Theo dõi hoạt động người dùng

### 2.9. Audit log và giám sát hệ thống

Các file:

- `audit.js`
- `auditController.js`
- `auditLogger.js`

Chức năng:

- Ghi nhật ký request và phản hồi
- Ghi nhật ký thao tác hệ thống
- Theo dõi hoạt động admin/moderator
- Hỗ trợ kiểm toán và bảo mật

### 2.10. Upload file

Các file:

- `uploadMiddleware.js`
- `uploads/`

Chức năng:

- Upload ảnh sự kiện / avatar / tài liệu
- Lưu file vào thư mục `uploads`
- Kiểm tra loại file và kích thước

---

## 3. Luồng xử lý request cơ bản

Request đi qua các tầng như sau:

1. Client gửi request tới server
2. `app.js` nhận request
3. Middleware chạy trước:
   - CORS
   - Rate limiting
   - Audit logging
   - Authentication (nếu route cần)
4. Route định tuyến sang controller phù hợp
5. Controller gọi model
6. Model truy vấn database
7. Kết quả trả về cho client dưới dạng JSON

Ví dụ:

- Request: đăng nhập
- route `/api/auth/login`
- controller xử lý dữ liệu
- model `User.findByEmail()`
- query PostgreSQL
- xác thực password
- trả về JWT

---

## 4. Cách lưu trữ database như thế nào

Dự án không dùng một database duy nhất mà áp dụng mô hình hybrid, gồm 3 tầng lưu trữ chính:

### 4.1. PostgreSQL - database chính cho dữ liệu quan hệ

File cấu hình: [server/src/config/database.js](../server/src/config/database.js)

Server kết nối PostgreSQL bằng `pg` và `Pool`:

- `POSTGRES_HOST`
- `POSTGRES_PORT`
- `POSTGRES_DB`
- `POSTGRES_USER`
- `POSTGRES_PASSWORD`

PostgreSQL dùng để lưu dữ liệu có cấu trúc và quan hệ chặt chẽ, ví dụ:

- `users`
- `events`
- `participants`
- `ratings`
- `categories`
- `notifications`
- `audit logs`

Lý do dùng PostgreSQL:

- Dữ liệu có quan hệ rõ ràng
- Cần truy vấn phức tạp và báo cáo thống kê
- Ưu tiên tính toàn vẹn dữ liệu (ACID)

Ví dụ: `User.js` và `Event.js` đều dùng `getPostgresPool()` để query dữ liệu trực tiếp trong PostgreSQL.

### 4.2. MongoDB - lưu dữ liệu phi cấu trúc / log / analytics

Theo mô tả trong [database/README.md](../database/README.md), MongoDB được dùng cho các dữ liệu linh hoạt như:

- comments
- user activities
- analytics
- system logs
- notification queue
- search index

MongoDB phù hợp khi dữ liệu không cố định schema, ví dụ:

- comment có thể có nested replies
- log có thể chứa metadata phức tạp
- activity tracking có nhiều loại dữ liệu khác nhau

Cấu hình MongoDB trong file `.env.example`:

- `MONGODB_URI=...`

Server gọi `mongoose.connect(...)` trong `connectMongoDB()` để mở kết nối.

### 4.3. Redis - bộ nhớ tạm, cache, session nhanh

File cấu hình: [server/src/config/redis.js](../server/src/config/redis.js)

Redis được dùng cho các tác vụ cần xử lý nhanh và dữ liệu tạm thời như:

- cache dữ liệu
- lưu session hoặc state tạm
- giảm tải database khi truy vấn lặp lại
- hỗ trợ rate limiting / tracking nhanh

Khi server khởi động, nó gọi:

- `connectRedis()`
- `client.connect()`

### 4.4. File upload - lưu cục bộ trên server

Trong `.env.example`, có cấu hình:

- `UPLOAD_DIR=uploads`
- `MAX_FILE_SIZE=10485760`
- `ALLOWED_FILE_TYPES=image/jpeg,...`

Do đó, các file ảnh hoặc tài liệu upload thường được lưu trực tiếp vào thư mục [server/uploads](../server/uploads).

---

## 5. Tổng kết kiến trúc dữ liệu

Mô hình dữ liệu của hệ thống có thể tóm gọn như sau:

- PostgreSQL: dữ liệu chính, quan hệ, người dùng, sự kiện, tham gia, đánh giá
- MongoDB: log, comment, hoạt động người dùng, analytics
- Redis: cache và dữ liệu tạm thời
- Local filesystem: file upload

Như vậy, server không lưu mọi thứ vào một nơi duy nhất mà chia theo đặc tính dữ liệu để tối ưu hiệu suất, tính bảo mật và tính mở rộng.

---

## 6. Kết luận

Server này là một backend REST API đầy đủ cho hệ thống quản lý sự kiện, bao gồm:

- xác thực người dùng
- quản lý sự kiện
- điểm danh QR
- bình luận và đánh giá
- thông báo
- thống kê
- audit log
- upload file

Về lưu trữ dữ liệu, hệ thống dùng kiến trúc hybrid:

- PostgreSQL cho dữ liệu nghiệp vụ chính
- MongoDB cho dữ liệu linh hoạt và analytics
- Redis cho cache và dữ liệu tạm
- Local upload folder cho file đính kèm

Đây là một thiết kế hợp lý cho hệ thống web có nhiều loại dữ liệu khác nhau và cần mở rộng trong tương lai.
