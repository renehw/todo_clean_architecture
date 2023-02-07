import 'dart:convert';

import 'package:todo_clean_architecture/features/album/domain/entities/album.dart';

class AlbumModel extends Album {
  const AlbumModel({
    final int? userId,
    final int? id,
    final String? title,
  }) : super(
          userId: userId,
          id: id,
          title: title,
        );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'id': id});
    result.addAll({'title': title});

    return result;
  }

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    return AlbumModel(
      userId: map['userId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AlbumModel.fromJson(source) => AlbumModel.fromMap(jsonDecode(source));
}
