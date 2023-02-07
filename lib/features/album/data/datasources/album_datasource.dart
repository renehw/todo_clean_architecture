import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_clean_architecture/core/error/failure.dart';
import 'package:todo_clean_architecture/core/ui/widets/constantes.dart';

import 'package:todo_clean_architecture/features/album/data/models/album_model.dart';
import 'package:todo_clean_architecture/features/album/domain/entities/album.dart';

abstract class AlbumRemoteDatasource {
  Future<List<AlbumModel>> getAllAlbuns();
  Future<AlbumModel?> getAlbum(int id);
  Future<AlbumModel?> updateAlbum(Album album);
  Future<AlbumModel?> deleteAlbum(int id);
  Future<AlbumModel?> createAlbum(Album album);
}

class AlbumRemoteDatasourceImpl implements AlbumRemoteDatasource {
  final http.Client cliente;

  AlbumRemoteDatasourceImpl({required this.cliente});

  @override
  Future<AlbumModel?> createAlbum(Album? album) async {
    try {
      if (album != null) {
        final response = await http.post(
          Uri.parse('$apiUrlBase/albums'),
          headers: apiHeaders,
          body: json.encode({'title': album.title}),
        );

        if (response.statusCode == 201) {
          return AlbumModel.fromJson(response.body);
        } else {
          throw HttpError('status code error ${response.statusCode}');
        }
      }
    } catch (e) {
      throw HttpError('Falha ao criar album $e');
    }

    return null;
  }

  @override
  Future<AlbumModel?> deleteAlbum(int? id) async {
    try {
      if (id != null) {
        final response = await http.delete(
          Uri.parse('$apiUrlBase/albums/$id'),
          headers: apiHeaders,
        );

        if (response.statusCode == 200) {
          return AlbumModel.fromJson(response.body);
        } else {
          throw HttpError('status code error ${response.statusCode}');
        }
      }
    } catch (e) {
      throw HttpError('Falha ao deletar album $e');
    }

    return null;
  }

  @override
  Future<AlbumModel?> getAlbum(int? id) async {
    try {
      if (id != null) {
        final response = await http.get(
          Uri.parse('$apiUrlBase/albums/$id'),
        );

        if (response.statusCode == 200) {
          return AlbumModel.fromJson(response.body);
        } else {
          throw HttpError('status code error ${response.statusCode}');
        }
      }
    } catch (e) {
      throw HttpError('Falha ao carregar album $e');
    }

    return null;
  }

  @override
  Future<List<AlbumModel>> getAllAlbuns() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrlBase/albuns'),
        headers: apiHeaders,
      );

      if (response.statusCode == 200) {
        List<AlbumModel> result = (json.decode(response.body) as List).map((i) => AlbumModel.fromMap(i)).toList();

        return result;
      } else {
        throw HttpError('status code error ${response.statusCode}');
      }
    } catch (e) {
      throw HttpError('Falha ao carregar os albuns $e');
    }
  }

  @override
  Future<AlbumModel?> updateAlbum(Album? album) async {
    try {
      if (album != null) {
        final response = await http.put(
          Uri.parse('$apiUrlBase/albums/${album.id}'),
          headers: apiHeaders,
          body: json.encode({'title': album.title}),
        );

        if (response.statusCode == 200) {
          return AlbumModel.fromJson(response.body);
        } else {
          throw HttpError('status code error ${response.statusCode}');
        }
      }
    } catch (e) {
      throw HttpError('Falha ao atualizar album $e');
    }

    return null;
  }
}
