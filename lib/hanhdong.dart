import 'package:flutter/material.dart';

class ActionMoviesScreen extends StatelessWidget {
  final List<Map<String, String>> movies = [
    {'image': 'assets/action1.jpg', 'title': 'John Wick'},
    {'image': 'assets/action2.jpg', 'title': 'Mad Max: Fury Road'},
    {'image': 'assets/action3.jpg', 'title': 'Gladiator'},
    {'image': 'assets/action4.jpg', 'title': 'Fast & Furious 9'},
    {'image': 'assets/action5.jpg', 'title': 'The Raid'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phim Hành Động'),
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
