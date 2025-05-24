part of '../base.dart';

abstract interface class UseCaseWithParams<Params, Result> {
  Future<Either<Failure, Result>> call(Params params);
}

abstract interface class UseCaseWithoutParams<Result> {
  Future<Either<Failure, Result>> call();
}
