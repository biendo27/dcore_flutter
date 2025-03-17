part of '../base.dart';

abstract interface class UseCase<T, P> {
  Future<T> call(P params);
}
