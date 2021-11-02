import 'package:flutter/material.dart';
import 'package:zaid_study/animation_route.dart';
import 'package:zaid_study/appbar.dart';
import 'package:zaid_study/models/fetch_photos_model.dart';
import 'package:zaid_study/networks/fetch_data.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key key}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  Future<List<Photos>> fetchPhotosValue;

  @override
  void initState() {
    super.initState();
    fetchPhotosValue = fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZaidAppBar(
        title: "Focus Image",
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: fetchPhotosValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _listData(snapshot.data, context);
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

  Widget _listData(List<Photos> data, parentContext) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              var nav = Navigator.of(context);
              nav.push<void>(
                focusImage(
                  parentContext,
                  SecondPage(data[index].url),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Image.network(data[index].url),
            ),
          );
        });
  }
}

class SecondPage extends StatelessWidget {
  final String imageAssetName;

  const SecondPage(this.imageAssetName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                imageAssetName,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
