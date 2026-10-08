import 'package:equatable/equatable.dart';

/// Базовый класс ошибок для доменного слоя.
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Ошибка сервера (5xx, 4xx).
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Ошибка соединения (нет сети, тайм-аут).
class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

/// Неизвестная ошибка.
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
