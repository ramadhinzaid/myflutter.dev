import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:zaid_study/models/fetch_album_model.dart';
import 'package:zaid_study/models/fetch_photos_model.dart';

uriParse(url) {
  return Uri.parse('https://jsonplaceholder.typicode.com/$url');
}

//fetch album
Future<List<Album>> fetchAlbum() async {
  final response = await http.get(uriParse("albums"));
  if (response.statusCode == 200) {
    return compute(parseAlbums, response.body);
  } else {
    throw Exception('Failed to load Album');
  }
}

//parsing album
List<Album> parseAlbums(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Album>((json) => Album.fromJson(json)).toList();
}

//fetch Photos
Future<List<Photos>> fetchPhotos() async {
  final response = await http.get(uriParse("photos"));
  if (response.statusCode == 200) {
    return compute(parsePhotos, response.body);
  } else {
    throw Exception('Failed to load Album');
  }
}

//parsing Photos
List<Photos> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photos>((json) => Photos.fromJson(json)).toList();
}
