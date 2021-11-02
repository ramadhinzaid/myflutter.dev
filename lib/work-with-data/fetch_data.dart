import 'package:flutter/material.dart';
import 'package:zaid_study/appbar.dart';
import 'package:zaid_study/models/fetch_album_model.dart';
import 'package:zaid_study/networks/fetch_data.dart';

class FetchData extends StatefulWidget {
  const FetchData({Key key}) : super(key: key);

  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  Future<List<Album>> fetchAlbumValue;

  @override
  void initState() {
    super.initState();
    fetchAlbumValue = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZaidAppBar(
        title: "Fetch Album",
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder<List<Album>>(
              future: fetchAlbumValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _listData(snapshot.data);
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                } else if (snapshot.connectionState == ConnectionState.none) {
                  //aply when no connection internet
                  return Center(child: Text('no internet connection'));
                }
                // By default, show a loading spinner.
                //you can aply shimmer in here
                return Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }

  Widget _listData(data) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(data[index].id.toString()),
            title: Text(data[index].title),
          );
        });
  }
}
