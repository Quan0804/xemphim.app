import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/movie.dart';
import 'movie_detail_screen.dart';

class WatchlistScreen extends StatefulWidget {
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  List<Movie> watchlist = [];
  final String watchlistKey = 'watchlist';

  @override
  void initState() {
    super.initState();
    _loadWatchlist();
  }

  Future<void> _loadWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    final String? watchlistJson = prefs.getString(watchlistKey);
    if (watchlistJson != null) {
      final List<dynamic> decodedList = json.decode(watchlistJson);
      setState(() {
        watchlist = decodedList.map((item) => Movie.fromJson(item)).toList();
      });
    }
  }

  Future<void> _removeFromWatchlist(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      watchlist.removeWhere((item) => item.id == movie.id);
    });
    final String encodedList = json.encode(watchlist
        .map((item) => {
              'id': item.id,
              'title': item.title,
              'description': item.description,
              'image': item.imageUrl,
              'trailerUrl': item.trailerUrl,
            })
        .toList());
    await prefs.setString(watchlistKey, encodedList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách xem sau'),
        backgroundColor: Colors.black,
      ),
      body: watchlist.isEmpty
          ? Center(
              child: Text(
                'Chưa có phim nào trong danh sách xem sau',
                style: TextStyle(color: Colors.white70),
              ),
            )
          : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: watchlist.length,
              itemBuilder: (context, index) {
                final movie = watchlist[index];
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
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: movie.imageUrl.startsWith('http')
                                ? NetworkImage(movie.imageUrl) as ImageProvider
                                : AssetImage(movie.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () => _removeFromWatchlist(movie),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            movie.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
