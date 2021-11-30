part of 'getalbum_bloc.dart';

@immutable
abstract class GetalbumState extends Equatable {}

class GetalbumInitial implements GetalbumState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class GetalbumLoading implements GetalbumState {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class GetalbumSuccess implements GetalbumState {
  final List<Album> albums;
  GetalbumSuccess(this.albums);
  @override
  List<Object> get props => [albums];

  @override
  bool get stringify => true;
}

class GetalbumFailed implements GetalbumState {
  final String error;
  GetalbumFailed(this.error);
  @override
  List<Object> get props => [error];

  @override
  bool get stringify => false;
}
