import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailScreen extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;
  final String trailerUrl;

  MovieDetailScreen({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.trailerUrl,
  });

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late YoutubePlayerController _controller;
  final String watchlistKey = 'watchlist';

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.trailerUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _addToWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    final String? watchlistJson = prefs.getString(watchlistKey);
    List<Map<String, dynamic>> watchlist = [];

    if (watchlistJson != null) {
      watchlist = List<Map<String, dynamic>>.from(json.decode(watchlistJson));
    }

    // Kiểm tra xem phim đã có trong danh sách chưa
    bool exists = watchlist.any((item) => item['title'] == widget.title);
    if (!exists) {
      watchlist.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'title': widget.title,
        'description': widget.description,
        'image': widget.imagePath,
        'trailerUrl': widget.trailerUrl,
      });

      await prefs.setString(watchlistKey, json.encode(watchlist));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã thêm vào danh sách xem sau')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phim đã có trong danh sách xem sau')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(),
              clipBehavior: Clip.hardEdge,
              child: widget.imagePath.startsWith('http')
                  ? Image.network(
                      widget.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/movie1.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.description,
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          _controller.play();
                        },
                        icon: Icon(Icons.play_arrow),
                        label: Text("Xem Trailer"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: _addToWatchlist,
                        icon: Icon(Icons.bookmark_add),
                        label: Text("Xem Sau"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.red,
                        progressColors: ProgressBarColors(
                          playedColor: Colors.red,
                          handleColor: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
