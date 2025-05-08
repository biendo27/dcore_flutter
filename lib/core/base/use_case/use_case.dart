part of '../base.dart';

abstract interface class UseCaseWithParams<Type, Params> {
  Future<Type> call(Params params);
}

abstract interface class UseCaseWithoutParams<Type> {
  Future<Type> call();
}
