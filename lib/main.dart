import 'package:flutter/material.dart';
import 'package:xemphim/movie_detail_screen.dart';
import 'package:xemphim/thongbao.dart';
import 'dart:async';
import 'package:xemphim/models/movie.dart';
import 'dangnhap.dart';
import 'danhgia.dart';
import 'dienanh.dart';
import 'phimbo.dart';
import 'hanhdong.dart';
import 'watchlist_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MovieScreen(),
    );
  }
}

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<String> _banners = [
    'assets/banner1.jpg',
    'assets/banner2.jpg',
    'assets/banner3.jpg',
    'assets/banner4.jpg',
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (mounted) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Container(
          width: screenWidth * 0.7,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Tìm phim bạn muốn xem',
              hintStyle: TextStyle(color: Colors.white70),
              prefixIcon: Icon(Icons.search, color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[800],
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReviewScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Lịch sử'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Phim yêu thích'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.bookmark),
              title: Text('Xem sau'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WatchlistScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Chuyển đổi kênh'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Ngôn ngữ'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.subtitles),
              title: Text('Phụ đề'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Row(
            children: [
              Text(
                'Chọn thể loại',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(Icons.arrow_drop_down, size: 24, color: Colors.white),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: screenHeight * 0.25,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _banners.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BannerDetailScreen(imagePath: _banners[index]),
                      ),
                    );
                  },
                  child: BannerImage(imagePath: _banners[index]),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GenreButton(
                    title: 'Điện ảnh',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CinemaScreen()),
                      );
                    },
                  ),
                  SizedBox(width: 20),
                  GenreButton(
                    title: 'Phim bộ',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TvSeriesScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 20),
                  GenreButton(
                    title: 'Hành động',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActionMoviesScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Top 3 phim hot',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MovieCard(
                  image: 'assets/movie1.jpg',
                  title: 'Thế Giới Hôn Nhân',
                  description:
                      'Bộ phim xoay quanh câu chuyện tình yêu và sự phản bội...',
                  trailerUrl:
                      'https://youtu.be/7eXQb3rcEjM?si=dpooGzIodIG_ZE6j',
                ),
                SizedBox(width: 20),
                MovieCard(
                  image: 'assets/movie2.jpg',
                  title: 'Always',
                  description: 'Một câu chuyện tình cảm đầy xúc động...',
                  trailerUrl:
                      'https://youtu.be/Iy2nPKrgRh8?si=ZKnyakssyA_SKS0Q',
                ),
                SizedBox(width: 20),
                MovieCard(
                  image: 'assets/movie3.jpg',
                  title: 'Cám',
                  description:
                      'Một bộ phim cổ trang lấy cảm hứng từ truyện cổ tích...',
                  trailerUrl:
                      'https://youtu.be/wI2Wd2yA8YE?si=OU2ypbng0mjL2uVX',
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Danh sách phim mới cập nhật',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                MovieCard(
                  image: 'assets/movie4.jpg',
                  title: 'Your Name',
                  description: 'Một bộ phim mới đầy hấp dẫn...',
                  trailerUrl: 'https://youtu.be/example1',
                ),
                SizedBox(width: 20),
                MovieCard(
                  image: 'assets/movie5.jpg',
                  title: 'Suzume',
                  description: 'Bộ phim được mong chờ nhất năm nay...',
                  trailerUrl: 'https://youtu.be/example2',
                ),
                SizedBox(width: 20),
                MovieCard(
                  image: 'assets/movie6.jpg',
                  title: 'Weathering With You',
                  description: 'Một siêu phẩm điện ảnh vừa ra mắt...',
                  trailerUrl: 'https://youtu.be/example3',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BannerDetailScreen extends StatelessWidget {
  final String imagePath;

  BannerDetailScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thông tin phim')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Đánh giá: ★★★★☆',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  'Năm sản xuất: 2023',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  'Tóm tắt: Đây là bộ phim hấp dẫn về...',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BannerImage extends StatelessWidget {
  final String imagePath;
  BannerImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class GenreButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  GenreButton({required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Text(title),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String trailerUrl;

  MovieCard({
    required this.image,
    required this.title,
    required this.description,
    required this.trailerUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(
              imagePath: image,
              title: title,
              description: description,
              trailerUrl: trailerUrl,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieListScreen extends StatelessWidget {
  final Future<List<Movie>> futureMovies;

  const MovieListScreen({required this.futureMovies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Danh sách phim")),
      body: FutureBuilder<List<Movie>>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "Lỗi khi tải phim 😢",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text("${snapshot.error}", textAlign: TextAlign.center),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Không có phim nào! 🧐"));
          }

          final movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                leading: Image.network(
                  movie.imageUrl,
                  width: 50,
                  height: 75,
                  fit: BoxFit.cover,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.description),
                onTap: () {
                  // Chuyển đến màn hình chi tiết phim
                },
              );
            },
          );
        },
      ),
    );
  }
}
