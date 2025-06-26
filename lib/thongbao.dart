import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          NotificationItem(
              title: 'Phim mới ra mắt!',
              subtitle: 'Xem ngay phim hành động mới nhất.'),
          NotificationItem(
              title: 'Giảm giá thành viên VIP!',
              subtitle: 'Nhận ưu đãi ngay hôm nay.'),
          NotificationItem(
              title: 'Phim yêu thích của bạn có tập mới!',
              subtitle: 'Cập nhật ngay bây giờ.'),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;

  NotificationItem({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      child: ListTile(
        title: Text(title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.white70)),
        leading: Icon(Icons.notifications, color: Colors.white),
        onTap: () {
          // Thêm hành động khi nhấn vào thông báo nếu cần
        },
      ),
    );
  }
}
