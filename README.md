# 📱 Ứng Dụng Xem Phim Trên Android - Flutter Project 🎬

## 🧠 Giới thiệu
Đây là một ứng dụng xem phim đơn giản được xây dựng bằng **Flutter** và chạy trên nền tảng **Android Studio**. Ứng dụng hỗ trợ các chức năng như:
- Xem danh sách phim mới cập nhật
- Xem trailer phim bằng YouTube
- Lưu phim vào danh sách "Xem sau"
- Tìm kiếm và phân loại phim theo thể loại

Ứng dụng sử dụng dữ liệu từ một API Mock (MockAPI) để hiển thị thông tin phim.

---

## 🚀 Công nghệ sử dụng

- **Flutter**: SDK chính để xây dựng UI đa nền tảng
- **Dart**: Ngôn ngữ lập trình
- **Android Studio**: IDE để build và run ứng dụng Android
- **Youtube Player Flutter**: Thư viện tích hợp video trailer từ YouTube
- **Shared Preferences**: Lưu danh sách "Xem sau" cục bộ
- **HTTP**: Gửi yêu cầu đến API mock để lấy dữ liệu phim

---

## 🧱 Cấu trúc thư mục

```
xemphim/
│
├── lib/
│   ├── main.dart                 # Trang chính và home UI
│   ├── models/
│   │   └── movie.dart            # Model Movie
│   ├── movie_detail_screen.dart # Màn hình chi tiết phim
│   ├── watchlist_screen.dart    # Màn hình "Xem sau"
│   ├── api/
│   │   └── api_service.dart      # Gọi API mock
│   ├── dangnhap.dart            # Giao diện đăng nhập
│   └── ...                      # Các trang thể loại, đánh giá,...
├── assets/
│   └── movieX.jpg, bannerX.jpg  # Ảnh poster, ảnh banner
├── pubspec.yaml                 # Danh sách dependencies
```

---

## 🛠 Cài đặt và chạy ứng dụng

### ⚙️ Cài đặt
1. Cài đặt Flutter: https://docs.flutter.dev/get-started/install
2. Cài Android Studio và cấu hình thiết bị ảo (AVD) hoặc kết nối thiết bị Android thật
3. Clone project:
```bash
git clone https://github.com/your-username/xemphim_flutter.git
cd xemphim_flutter
flutter pub get
```

---

### ▶️ Chạy ứng dụng

```bash
flutter run
```

---

## 📦 Các thư viện đã dùng

| Thư viện                  | Chức năng                                       |
|---------------------------|--------------------------------------------------|
| `youtube_player_flutter` | Xem trailer trực tiếp từ YouTube                |
| `shared_preferences`     | Lưu danh sách phim xem sau                      |
| `http`                   | Gửi yêu cầu và nhận dữ liệu từ MockAPI          |
| `flutter_launcher_icons` | Thiết lập icon app                               |

---

## 📌 Ưu điểm
- Giao diện hiện đại, tối ưu cho người dùng mobile
- Tích hợp trình phát trailer từ YouTube
- Dễ dàng mở rộng thêm tính năng như đánh giá phim, đăng nhập,...

## ⚠️ Nhược điểm
- Dữ liệu lấy từ API mock, không có hệ thống backend thực tế
- Chưa có phân quyền người dùng và hệ thống tài khoản
- Ứng dụng cần được tối ưu thêm về hiệu năng và bảo mật

---

## 📩 Liên hệ
- Tác giả: **[Tên của bạn]**
- Email: example@gmail.com

---

> *Project này mang tính học thuật và demo, không dùng để kinh doanh hoặc vi phạm bản quyền nội dung phim.*
