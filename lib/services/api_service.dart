import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  static const String baseUrl =
      "https://67bf2d89b2320ee05012df4c.mockapi.io/phim";
  static Future<List<Movie>> fetchMovies() async {
    try {
      print("Đang gọi API từ: $baseUrl");
      final response = await http.get(Uri.parse(baseUrl));
      print("Status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        List<List<dynamic>> jsonData =
            List<List<dynamic>>.from(jsonDecode(response.body));
        if (jsonData.isNotEmpty) {
          List<dynamic> jsonList = jsonData[0];
          print("Số lượng phim nhận được: ${jsonList.length}");
          final movies = jsonList.map((json) => Movie.fromJson(json)).toList();
          print("Đã parse thành công ${movies.length} phim");
          return movies;
        }
        return [];
      } else {
        print("Lỗi API: ${response.statusCode}");
        print("Response body: ${response.body}");
        return [];
      }
    } catch (e) {
      print("Lỗi khi gọi API: $e");
      return [];
    }
  }
}
