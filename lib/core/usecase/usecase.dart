import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Базовый UseCase: принимает Params, возвращает Either<Failure, Output>.
abstract class UseCase<Output, Params> {
  Future<Either<Failure, Output>> call(Params params);
}

/// Для UseCase без параметров.
class NoParams {
  const NoParams();
}
