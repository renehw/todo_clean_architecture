part of 'album_controller.dart';

enum AlbumStatus {
  empty,
  initial,
  loading,
  loaded,
  error,
}

class AlbumState extends Equatable {
  final AlbumStatus status;
  final List<Album> album;
  final String? errorMessage;

  const AlbumState({
    required this.status,
    required this.album,
    this.errorMessage,
  });

  AlbumState.initial()
      : status = AlbumStatus.initial,
        album = [],
        errorMessage = null;

  @override
  List<Object?> get props => [status, album, errorMessage];

  AlbumState copyWith({
    AlbumStatus? status,
    List<Album>? album,
    String? errorMessage,
  }) {
    return AlbumState(
      status: status ?? this.status,
      album: album ?? this.album,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
