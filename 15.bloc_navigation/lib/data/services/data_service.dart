import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/post.dart';

class DataService {
  final String _baseUrl = 'jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPosts() async {
    try {
      final Uri url = Uri.https(_baseUrl, '/posts');

      var response = await http.get(url);

      List<dynamic> data = json.decode(response.body);

      List<Post> posts = data.map((post) => Post.fromJson(post)).toList();

      return posts;
    } catch (e) {
      rethrow;
    }
  }
}
