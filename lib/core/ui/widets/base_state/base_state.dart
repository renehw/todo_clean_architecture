import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseState<T extends StatefulWidget, C extends BlocBase> extends State<T> {
  late final C controller;

  @override
  void initState() {
    super.initState();

    controller = context.read<C>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onReady();
    });
  }

  void onReady() {}
}
