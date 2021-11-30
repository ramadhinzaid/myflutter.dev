import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zaid_study/animation_route.dart';
import 'package:zaid_study/appbar.dart';
import 'package:zaid_study/getAPIbloc/blocs/getAlbumbloc/getalbum_bloc.dart';
import 'package:zaid_study/getAPIbloc/repository/getAlbumrepo/getAlbumrepo.dart';
import 'package:zaid_study/models/fetch_album_model.dart';

class AlbumView extends StatefulWidget {
  const AlbumView({Key key}) : super(key: key);

  @override
  _AlbumViewState createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  List<Album> albums = List();
  GetalbumBloc getalbumBloc;

  @override
  void initState() {
    getalbumBloc = GetalbumBloc(GetAlbumRepository());
    dogetAlbum();
    super.initState();
  }

  @override
  void dispose() {
    getalbumBloc.close();
    super.dispose();
  }

  void dogetAlbum() {
    getalbumBloc.add(GetAllAlbums());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Bloc"),
        actions: [
          IconButton(
              icon: Icon(Icons.people),
              onPressed: () =>
                  Navigator.of(context).push(scaleRoute(AlbumPageTwo())))
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          // child: BlocBuilder<GetalbumBloc, GetalbumState>(
          //   builder: (context, state) {
          //     if (state is GetalbumFailed) {
          //       return _messageFailed(state.error);
          //     } else if (state is GetalbumSuccess) {
          //       albums.clear();
          //       albums.addAll(state.albums);
          //       return Stack(
          //         children: [
          //           Container(
          //               height: MediaQuery.of(context).size.height,
          //               child: _listAlbum()),
          //         ],
          //       );
          //     } else if (state is GetalbumLoading) {
          //       return _getAlbumLoading(state);
          //     }
          //     return SizedBox();
          //   },
          // ),

          child: BlocConsumer<GetalbumBloc, GetalbumState>(
            cubit: getalbumBloc,
            listener: (context, state) {
              //tidak bisa buat widget disini
              if (state is GetalbumFailed) {
                _messageFailed(state.error);
              } else if (state is GetalbumSuccess) {
                albums.clear();
                albums.addAll(state.albums);
              }
            },
            builder: (context, state) {
              if (state is GetalbumFailed) {
                return _messageFailed(state.error);
              } else if (state is GetalbumSuccess) {
                return Stack(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height,
                        child: _listAlbum()),
                  ],
                );
              } else if (state is GetalbumLoading) {
                return _getAlbumLoading(state);
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _listAlbum() {
    if (albums.length > 0) {
      return ListView.builder(
          itemCount: albums.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text(albums[index].id.toString()),
              title: Text(albums[index].title),
            );
          });
    } else {
      return SizedBox(
        child: Center(
          child: Text("Empty List"),
        ),
      );
    }
  }

  Widget _messageFailed(state) {
    print({state, "FAILED"});
    return Center(
      child: Text(
        state,
        style: TextStyle(
          color: Colors.red,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _getAlbumLoading(state) {
    if (state is GetalbumLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox();
  }
}

class AlbumPageTwo extends StatefulWidget {
  const AlbumPageTwo({Key key}) : super(key: key);

  @override
  _AlbumPageTwoState createState() => _AlbumPageTwoState();
}

class _AlbumPageTwoState extends State<AlbumPageTwo> {
  List<Album> albums = List();
  GetalbumBloc getalbumBloc;

  @override
  void initState() {
    getalbumBloc = GetalbumBloc(GetAlbumRepository());
    super.initState();
  }

  @override
  void dispose() {
    getalbumBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZaidAppBar(
        title: "HALo",
      ),
      body: BlocBuilder<GetalbumBloc, GetalbumState>(
        builder: (context, state) {
          print(state.props);
          return Text("OKE");
        },
      ),
    );
  }

  Widget _listAlbum() {
    if (albums.length > 0) {
      return ListView.builder(
          itemCount: albums.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text(albums[index].id.toString()),
              title: Text(albums[index].title),
            );
          });
    } else {
      return SizedBox(
        child: Center(
          child: Text("Empty List"),
        ),
      );
    }
  }
}
