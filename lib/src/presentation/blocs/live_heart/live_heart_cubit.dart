part of '../blocs.dart';

@lazySingleton
class LiveHeartCubit extends Cubit<int> {
  LiveHeartCubit() : super(0);

  void reset() => emit(0);

  void addHeart() => emit(state + 1);

  void removeHeart() => emit(state - 1);
}
