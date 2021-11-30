part of 'getalbum_bloc.dart';

@immutable
abstract class GetalbumEvent extends Equatable {}

class GetAllAlbums implements GetalbumEvent {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
