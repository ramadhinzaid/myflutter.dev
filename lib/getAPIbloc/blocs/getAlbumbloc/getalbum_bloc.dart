import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:zaid_study/getAPIbloc/repository/getAlbumrepo/getAlbumrepo.dart';
import 'package:zaid_study/models/fetch_album_model.dart';

part 'getalbum_event.dart';
part 'getalbum_state.dart';

class GetalbumBloc extends Bloc<GetalbumEvent, GetalbumState> {
  final GetAlbumRepository getAlbumRepository;

  GetalbumBloc(this.getAlbumRepository) : super(GetalbumInitial());

  @override
  Stream<GetalbumState> mapEventToState(GetalbumEvent event) async* {
    if (event is GetAllAlbums) {
      yield* doGetAlbum();
    }
  }

  Stream<GetalbumState> doGetAlbum() async* {
    try {
      yield GetalbumLoading();
      List<Album> getAlbum = await getAlbumRepository.fetchAlbum();
      yield GetalbumSuccess(getAlbum);
    } catch (e) {
      yield GetalbumFailed(
        e.toString(),
      );
    }
  }
}
