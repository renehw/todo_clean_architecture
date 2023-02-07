import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:todo_clean_architecture/features/album/data/datasources/album_datasource.dart';
import 'package:todo_clean_architecture/features/album/data/repositories/album_repository_impl.dart';
import 'package:todo_clean_architecture/features/album/domain/repositories/album_repository.dart';
import 'package:todo_clean_architecture/features/album/domain/usecases/album_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Repository
  sl.registerLazySingleton<AlbumRepository>(
    () => AlbumRepositoryImpl(albumRemoteDatasource: sl<AlbumRemoteDatasource>()),
  );

  sl.registerLazySingleton(() => UpdateAlbum(sl<AlbumRepository>()));
  sl.registerLazySingleton(() => DeleteAlbum(sl<AlbumRepository>()));
  sl.registerLazySingleton(() => CreateAlbum(sl<AlbumRepository>()));
  sl.registerLazySingleton(() => GetAlbum(sl<AlbumRepository>()));
  sl.registerLazySingleton(() => GetAlbuns(sl<AlbumRepository>()));

  //DataSource
  sl.registerLazySingleton<AlbumRemoteDatasource>(
    () => AlbumRemoteDatasourceImpl(cliente: sl()),
  );

  //! Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => DataConnectionChecker());
}

Future<void> initTest() async {}
