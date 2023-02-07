import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_architecture/core/ui/widets/base_state/base_state.dart';
import 'package:todo_clean_architecture/features/album/data/models/album_model.dart';
import 'package:todo_clean_architecture/features/album/domain/entities/album.dart';
import 'package:todo_clean_architecture/features/album/presentation/bloc/album_controller.dart';
import 'package:todo_clean_architecture/injections_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumController(),
      child: MaterialApp(
        title: 'Flutter Bloc',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends BaseState<MyHomePage, AlbumController> {
  @override
  void onReady() {
    controller.loadAllAlbuns();
    super.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Bloc demo'),
      ),
      body: Center(
        child: BlocListener<AlbumController, AlbumState>(
          listener: (context, state) {
            if (state.status == AlbumStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage ?? '')));
            }
          },
          child: _blocBuilder(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _modalAddAlbum(context: context);
        },
      ),
    );
  }

  _blocBuilder() {
    return BlocBuilder<AlbumController, AlbumState>(
      builder: (context, state) {
        if (state.status == AlbumStatus.initial) {
          return const Center(
            child: Text('Initial'),
          );
        } else if (state.status == AlbumStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == AlbumStatus.loaded) {
          return Column(
            children: [
              Text('Total Albuns: ${state.album.length}'),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.album.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.blue,
                      ),
                      child: ListTile(
                        title: Text(state.album[index].title ?? ''),
                        trailing: Wrap(
                          children: [
                            IconButton(
                              onPressed: () => _modalUpdate(album: state.album[index], context: context),
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onDismissed: (DismissDirection direction) {
                        controller.albumDelete(state.album[index].id!);

                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Excluindo...')));
                      },
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state.status == AlbumStatus.error) {
          return const Center(
            child: Text('Error'),
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('Nenhum dado a ser exibido')],
          ),
        );
      },
    );
  }

  _modalUpdate({required Album album, required BuildContext context}) {
    String title = album.title ?? '';
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          title: const Text('Alterar'),
          content: Wrap(
            children: [
              TextFormField(
                initialValue: album.title,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Title'),
                ),
                onChanged: (value) => title = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                controller.albumUpdate(AlbumModel(userId: album.userId, id: album.id, title: title));
                Navigator.pop(context);
              },
              child: const Text('Alterar'),
            ),
          ],
        );
      },
    );
  }

  _modalAddAlbum({required BuildContext context}) {
    String? title;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          title: const Text('Adicionar'),
          content: Wrap(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Title'),
                ),
                onChanged: (value) => title = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                controller.addNewAlbum(AlbumModel(title: title));
                Navigator.pop(context);
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
