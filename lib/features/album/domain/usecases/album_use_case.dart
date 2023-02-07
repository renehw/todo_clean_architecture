import 'package:dartz/dartz.dart';
import 'package:todo_clean_architecture/core/error/failure.dart';
import 'package:todo_clean_architecture/features/album/domain/entities/album.dart' as entitie;
import 'package:todo_clean_architecture/features/album/domain/repositories/album_repository.dart';

class CreateAlbum {
  final AlbumRepository _repository;

  CreateAlbum(AlbumRepository repository) : _repository = repository;

  Future<Either<Failure, entitie.Album>> call(entitie.Album album) async => await _repository.createAlbum(album);
}

class DeleteAlbum {
  final AlbumRepository _repository;

  DeleteAlbum(AlbumRepository repository) : _repository = repository;

  Future<Either<Failure, entitie.Album>> call(int id) async => await _repository.deleteAlbum(id);
}

class GetAlbum {
  final AlbumRepository _repository;

  GetAlbum(AlbumRepository repository) : _repository = repository;

  Future<Either<Failure, entitie.Album>> call(int id) async => await _repository.getAlbum(id);
}

class GetAlbuns {
  final AlbumRepository _repository;

  GetAlbuns(AlbumRepository repository) : _repository = repository;

  Future<Either<Failure, List<entitie.Album>>> call() async => await _repository.getAllAlbuns();
}

class UpdateAlbum {
  final AlbumRepository _repository;

  UpdateAlbum(AlbumRepository repository) : _repository = repository;

  Future<Either<Failure, entitie.Album>> call(entitie.Album album) async => await _repository.updateAlbum(album);
}
