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
