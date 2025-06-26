import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đánh giá phim'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ReviewItem(
              username: 'Nguyễn Văn A',
              rating: 5,
              comment: 'Phim quá hay! Nội dung hấp dẫn từ đầu đến cuối.'),
          ReviewItem(
              username: 'Trần Thị B',
              rating: 4,
              comment:
                  'Hình ảnh đẹp, diễn xuất tốt. Nhưng cốt truyện hơi dễ đoán.'),
          ReviewItem(
              username: 'Lê Hoàng C',
              rating: 3,
              comment: 'Phim ổn, nhưng chưa thật sự xuất sắc.'),
        ],
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final String username;
  final int rating;
  final String comment;

  ReviewItem(
      {required this.username, required this.rating, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      child: ListTile(
        title: Text(
          username,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '⭐ ' * rating,
              style: TextStyle(color: Colors.yellow),
            ),
            SizedBox(height: 5),
            Text(
              comment,
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
