import 'dart:convert';

import 'package:http/http.dart' as http;

import 'config.dart';

class Photo {
  String id;
  int width;
  int height;
  String rawUrl;
  String smallUrl;
  String thumbUrl;

  Photo(Map<String, Object> map) {
    try {
      id = map["id"];
      width = map["width"];
      height = map["height"];
      Map<String, dynamic> urls = map["urls"];
      rawUrl = urls["raw"];
      smallUrl = urls["small"];
      thumbUrl = urls["thumb"];
    } catch (e) {
      print(e.toString());
    }
  }
}

class SearchResult {
  int total = 0;
  int totalPages = 0;
  List<Photo> results = List<Photo>();

  SearchResult();

  SearchResult.fromMap(Map<String, Object> response) {
    try {
      total = response["total"];
      totalPages = response["total_pages"];
      List<dynamic> items = response["results"];
      for (int i = 0; i < items.length; i++) {
        results.add(Photo(items[i]));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class UnsplashApi {
  static final String SERVER_URL = "https://api.unsplash.com/";

  static Future<SearchResult> search(String search) async {
    try {
      String url = SERVER_URL + "search/photos?query=" + Uri.encodeFull(search);
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': "Client-ID " + UNSPLASH_KEY,
        'Accept-Version': "v1",
      };

      final response = await http.get(url, headers: headers);
      final responseJson = json.decode(response.body);
      print(responseJson);
      return SearchResult.fromMap(responseJson);
    } catch (e) {
      print(e.toString());
    }
    return SearchResult();
  }
}
