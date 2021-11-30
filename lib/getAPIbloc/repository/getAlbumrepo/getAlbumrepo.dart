import 'package:flutter/foundation.dart';
import 'package:zaid_study/models/fetch_album_model.dart';
import 'package:http/http.dart' as http;
import 'package:zaid_study/networks/fetch_data.dart';

class GetAlbumRepository {
  Future<List<Album>> fetchAlbum() async {
    final response = await http.get(uriParse("albums"));
    if (response.statusCode == 200) {
      return compute(parseAlbums, response.body);
    } else {
      throw Exception('Failed to load Album');
    }
  }
}
