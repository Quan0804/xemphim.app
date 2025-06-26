import 'package:flutter/material.dart';

class TvSeriesScreen extends StatelessWidget {
  final List<Map<String, String>> movies = [
    {'image': 'assets/series1.jpg', 'title': 'Breaking Bad'},
    {'image': 'assets/series2.jpg', 'title': 'Stranger Things'},
    {'image': 'assets/series3.jpg', 'title': 'Game of Thrones'},
    {'image': 'assets/series4.jpg', 'title': 'The Witcher'},
    {'image': 'assets/series5.jpg', 'title': 'Money Heist'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phim Bộ'),
        backgroundColor: Colors.black,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: MovieCard(
              image: movies[index]['image']!,
              title: movies[index]['title']!,
            ),
          );
        },
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String image;
  final String title;

  MovieCard({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
