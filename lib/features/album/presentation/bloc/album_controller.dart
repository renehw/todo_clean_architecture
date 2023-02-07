import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_clean_architecture/core/ui/widets/constantes.dart';

import 'package:todo_clean_architecture/features/album/domain/entities/album.dart';
import 'package:todo_clean_architecture/features/album/domain/usecases/album_use_case.dart';
import 'package:todo_clean_architecture/injections_container.dart' as di;

part 'album_state.dart';

class AlbumController extends Cubit<AlbumState> {
  AlbumController() : super(AlbumState.initial());

  Future<void> loadAllAlbuns() async {
    try {
      emit(state.copyWith(status: AlbumStatus.loading));
      final getAlbuns = di.sl<GetAlbuns>();

      getAlbuns.call().then(
        (albuns) {
          albuns.fold(
            (l) => emit(state.copyWith(status: AlbumStatus.error, errorMessage: l.message)),
            (r) => emit(state.copyWith(status: AlbumStatus.loaded, album: r)),
          );
        },
      );
    } catch (_) {
      emit(state.copyWith(status: AlbumStatus.error, errorMessage: errorGenerico));
    }
  }

  Future<void> loadAlbum(int id) async {
    final getAlbum = di.sl<GetAlbum>();

    try {
      emit(state.copyWith(status: AlbumStatus.loading));

      getAlbum.call(id).then(
        (albuns) {
          albuns.fold(
            (l) => emit(state.copyWith(status: AlbumStatus.error, errorMessage: l.message)),
            (r) => emit(state.copyWith(status: AlbumStatus.loaded, album: state.album..add(r))),
          );
        },
      );
    } catch (_) {
      emit(state.copyWith(status: AlbumStatus.error, errorMessage: errorGenerico));
    }
  }

  Future<void> addNewAlbum(Album album) async {
    final createAlbum = di.sl<CreateAlbum>();

    try {
      emit(state.copyWith(status: AlbumStatus.loading));

      await createAlbum.call(album).then(
        (newAlbum) {
          newAlbum.fold(
            (l) => emit(state.copyWith(status: AlbumStatus.error, errorMessage: l.message)),
            (r) => emit(
              state.copyWith(
                status: AlbumStatus.loaded,
                album: List<Album>.from(state.album)..add(r),
              ),
            ),
          );
        },
      );
    } catch (_) {
      emit(state.copyWith(status: AlbumStatus.error, errorMessage: errorGenerico));
    }
  }

  Future<void> albumUpdate(Album album) async {
    final updateAlbum = di.sl<UpdateAlbum>();

    try {
      emit(state.copyWith(status: AlbumStatus.loading));

      await updateAlbum.call(album).then(
        (newAlbum) {
          newAlbum.fold(
            (l) => emit(state.copyWith(status: AlbumStatus.error, errorMessage: l.message)),
            (r) => emit(
              state.copyWith(
                status: AlbumStatus.loaded,
                album: state.album.map((album) => album.id == r.id ? r : album).toList(),
              ),
            ),
          );
        },
      );
    } catch (_) {
      emit(state.copyWith(status: AlbumStatus.error, errorMessage: errorGenerico));
    }
  }

  Future<void> albumDelete(int id) async {
    final deleteAlbum = di.sl<DeleteAlbum>();

    try {
      emit(state.copyWith(status: AlbumStatus.loading));

      await deleteAlbum.call(id).then(
        (deletedAlbum) {
          deletedAlbum.fold(
            (l) => emit(state.copyWith(status: AlbumStatus.error, errorMessage: l.message)),
            (r) => emit(
              state.copyWith(
                status: AlbumStatus.loaded,
                album: state.album.where((e) => e.id != id).toList(),
              ),
            ),
          );
        },
      );
    } catch (_) {
      emit(state.copyWith(status: AlbumStatus.error, errorMessage: errorGenerico));
    }
  }
}
