import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie.dart';
import '../movie_detail_screen.dart';

class CinemaScreen extends StatefulWidget {
  @override
  _CinemaScreenState createState() => _CinemaScreenState();
}

class _CinemaScreenState extends State<CinemaScreen> {
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = ApiService.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phim Điện Ảnh'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Movie>>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error in CinemaScreen: ${snapshot.error}');
            if (snapshot.error is Exception) {
              print('Stack trace: ${(snapshot.error as Exception).toString()}');
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Đã xảy ra lỗi: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Không có dữ liệu phim'),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final movie = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(
                        imagePath: movie.imageUrl,
                        title: movie.title,
                        description: movie.description,
                        trailerUrl: movie.trailerUrl,
                      ),
                    ),
                  );
                },
                child: MovieCard(
                  image: movie.imageUrl,
                  title: movie.title,
                ),
              );
            },
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
            ),
            clipBehavior: Clip.hardEdge,
            child: image.startsWith('http')
                ? Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/movie1.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
