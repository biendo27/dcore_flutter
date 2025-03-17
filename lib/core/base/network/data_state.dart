part of '../base.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;

  DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess({required T data}) : super(data: data);
}

class DataError<T> extends DataState<T> {
  DataError({required DioException super.error, super.data});
}
