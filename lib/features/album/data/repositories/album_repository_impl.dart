import 'package:dartz/dartz.dart';

import 'package:todo_clean_architecture/core/error/failure.dart';
import 'package:todo_clean_architecture/features/album/data/datasources/album_datasource.dart';
import 'package:todo_clean_architecture/features/album/data/models/album_model.dart';
import 'package:todo_clean_architecture/features/album/domain/entities/album.dart' as entitie;
import 'package:todo_clean_architecture/features/album/domain/repositories/album_repository.dart';

class AlbumRepositoryImpl extends AlbumRepository {
  final AlbumRemoteDatasource albumRemoteDatasource;

  AlbumRepositoryImpl({
    required this.albumRemoteDatasource,
  });

  @override
  Future<Either<Failure, entitie.Album>> createAlbum(entitie.Album album) async {
    try {
      final albumReceived = await albumRemoteDatasource.createAlbum(album);

      return Right(albumReceived as entitie.Album);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, entitie.Album>> deleteAlbum(int id) async {
    try {
      return Right((await albumRemoteDatasource.deleteAlbum(id)) as entitie.Album);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, entitie.Album>> getAlbum(int id) async {
    try {
      return Right((await albumRemoteDatasource.getAlbum(id)) as entitie.Album);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<entitie.Album>>> getAllAlbuns() async {
    try {
      final List<AlbumModel> album = await albumRemoteDatasource.getAllAlbuns();

      return Right(album);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, entitie.Album>> updateAlbum(entitie.Album album) async {
    try {
      return Right((await albumRemoteDatasource.updateAlbum(album)) as entitie.Album);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
