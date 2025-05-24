part of '../base.dart';

mixin BlocActionMixin<Event, State> on BlocBase<State> {
  Future<void> executeAction<T>({
    required Future<BaseResponse<T>> Function() action,
    State Function(State currentState, {required bool isLoading})? setLoadingState,
    Function(BaseResponse<T>)? onSuccess,
    Function(String)? onFailure,
  }) async {
    if (setLoadingState != null) {
      emit(setLoadingState(state, isLoading: true));
    }
    try {
      final response = await action();
      if (response.status && response.data != null) {
        onSuccess?.call(response);
      } else {
        onFailure?.call(response.message);
      }
    } catch (e) {
      LogDev.error('Error: $e');
      onFailure?.call(e.toString());
    } finally {
      if (setLoadingState != null) {
        emit(setLoadingState(state, isLoading: false));
      }
    }
  }

  Future<void> executeEmptyAction({
    required Future<BaseResponse> Function() action,
    State Function(State currentState, {required bool isLoading})? setLoadingState,
    Function(BaseResponse)? onSuccess,
    Function(String)? onFailure,
  }) async {
    if (setLoadingState != null) {
      emit(setLoadingState(state, isLoading: true));
    }
    try {
      final response = await action();
      if (response.status) {
        onSuccess?.call(response);
      } else {
        onFailure?.call(response.message);
      }
    } catch (e) {
      LogDev.error('Error: $e');
      onFailure?.call(e.toString());
    } finally {
      if (setLoadingState != null) {
        emit(setLoadingState(state, isLoading: false));
      }
    }
  }

  Future<void> executeListAction<T>({
    required Future<BaseResponseList<T>> Function() action,
    State Function(State currentState, {required bool isLoading})? setLoadingState,
    Function(BaseResponseList<T>)? onSuccess,
    Function(String)? onFailure,
  }) async {
    if (setLoadingState != null) {
      emit(setLoadingState(state, isLoading: true));
    }
    try {
      final response = await action();
      if (response.status && response.data.isNotEmpty) {
        onSuccess?.call(response);
      } else {
        onFailure?.call(response.message);
      }
    } catch (e) {
      LogDev.error('Error: $e');
      onFailure?.call(e.toString());
    } finally {
      if (setLoadingState != null) {
        emit(setLoadingState(state, isLoading: false));
      }
    }
  }

  Future<void> executePageBreakAction<T>({
    bool isInit = false,
    required Future<BaseResponse<BasePageBreak<T>>> Function() action,
    required BasePageBreak<T> currentPageData,
    required State Function(State currentState, {required BasePageBreak<T> mergedPageBreakData}) setPageBreakState,
    Function(BaseResponse<BasePageBreak<T>>)? onSuccess,
    Function(String)? onFailure,
    State Function(State currentState, {required bool isLoading})? setLoadingState,
  }) async {
    if (setLoadingState != null) {
      emit(setLoadingState(state, isLoading: true));
    }
    try {
      final response = await action();
      if (response.status && response.data != null) {
        List<T> currentData = isInit ? [] : currentPageData.data;
        final mergedPageBreak = BasePageBreak<T>(
          currentPage: response.data!.currentPage,
          lastPage: response.data!.lastPage,
          perPage: response.data!.perPage,
          total: response.data!.total,
          data: [...currentData, ...response.data!.data],
        );
        emit(setPageBreakState(state, mergedPageBreakData: mergedPageBreak));
        onSuccess?.call(response);
      } else {
        onFailure?.call(response.message);
      }
    } catch (e) {
      LogDev.error('Error: $e');
      onFailure?.call(e.toString());
    } finally {
      if (setLoadingState != null) {
        emit(setLoadingState(state, isLoading: false));
      }
    }
  }
}

mixin BlocUseCaseHandlerMixin<Event, State> on BlocBase<State> {
  Future<void> executeUseCase<T>({
    required Future<Either<Failure, BaseResponse<T>>> Function() usecase,
    State Function(State currentState, {required bool isLoading})? setLoadingState,
    Function(BaseResponse<T>)? onSuccess,
    Function(String)? onFailure,
  }) async {
    if (setLoadingState != null) {
      emit(setLoadingState(state, isLoading: true));
    }

    final Either<Failure, BaseResponse<T>> response = await usecase();
    response.fold(
      (failure) => onFailure?.call(failure.toString()),
      (success) => onSuccess?.call(success),
    );

    if (setLoadingState != null) {
      emit(setLoadingState(state, isLoading: false));
    }
  }

  Future<void> executeEmptyUseCase({
    required Future<Either<Failure, BaseResponse>> Function() usecase,
    State Function(State currentState, {required bool isLoading})? setLoadingState,
    Function(BaseResponse)? onSuccess,
    Function(String)? onFailure,
  }) async {
    if (setLoadingState != null) {
      emit(setLoadingState(state, isLoading: true));
    }
    final Either<Failure, BaseResponse> response = await usecase();
    response.fold(
      (failure) => onFailure?.call(failure.toString()),
      (success) => onSuccess?.call(success),
    );
    if (setLoadingState != null) {
      emit(setLoadingState(state, isLoading: false));
    }
  }

  Future<void> executeListUseCase<T>({
    required Future<Either<Failure, BaseResponseList<T>>> Function() usecase,
    State Function(State currentState, {required bool isLoading})? setLoadingState,
    Function(BaseResponseList<T>)? onSuccess,
    Function(String)? onFailure,
  }) async {
    if (setLoadingState != null) {
      emit(setLoadingState(state, isLoading: true));
    }
    final Either<Failure, BaseResponseList<T>> response = await usecase();
    response.fold(
      (failure) => onFailure?.call(failure.toString()),
      (success) => onSuccess?.call(success),
    );
    if (setLoadingState != null) {
      emit(setLoadingState(state, isLoading: false));
    }
  }

  Future<void> executePageBreakUseCase<T>({
    required Future<Either<Failure, BaseResponse<BasePageBreak<T>>>> Function() usecase,
    required BasePageBreak<T> currentPageData,
    required bool isInit,
    required State Function(State currentState, {required BasePageBreak<T> mergedPageBreakData}) setPageBreakState,
    Function(BaseResponse<BasePageBreak<T>>)? onSuccess,
    Function(String)? onFailure,
    State Function(State currentState, {required bool isLoading})? setLoadingState,
  }) async {
    if (setLoadingState != null) {
      emit(setLoadingState(state, isLoading: true));
    }
    final Either<Failure, BaseResponse<BasePageBreak<T>>> response = await usecase();
    response.fold(
      (failure) => onFailure?.call(failure.toString()),
      (success) {
        List<T> currentData = isInit ? [] : currentPageData.data;
        final mergedPageBreak = BasePageBreak<T>(
          currentPage: success.data!.currentPage,
          lastPage: success.data!.lastPage,
          perPage: success.data!.perPage,
          total: success.data!.total,
          data: [...currentData, ...success.data!.data],
        );
        emit(setPageBreakState(state, mergedPageBreakData: mergedPageBreak));
        onSuccess?.call(success);
      },
    );
    if (setLoadingState != null) {
      emit(setLoadingState(state, isLoading: false));
    }
  }

  Future<void> executeCustomUseCase<T>({
    required Future<Either<Failure, T>> Function() usecase,
    State Function(State currentState, {required bool isLoading})? setLoadingState,
    Function(T)? onSuccess,
    Function(String)? onFailure,
  }) async {
    if (setLoadingState != null) {
      emit(setLoadingState(state, isLoading: true));
    }
    final Either<Failure, T> response = await usecase();
    response.fold(
      (failure) => onFailure?.call(failure.toString()),
      (success) => onSuccess?.call(success),
    );
    if (setLoadingState != null) {
      emit(setLoadingState(state, isLoading: false));
    }
  }
}
