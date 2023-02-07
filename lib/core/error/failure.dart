import 'package:equatable/equatable.dart';

class Failure extends Equatable implements Exception {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class HttpError extends Failure {
  const HttpError(String message) : super(message);
}
