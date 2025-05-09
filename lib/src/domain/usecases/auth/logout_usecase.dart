part of '../usecases.dart';

@lazySingleton
class LogoutUsecase implements UseCaseWithoutParams<BaseResponse> {
  final IAuthRepository _authRepository;
  LogoutUsecase(this._authRepository);

  @override
  Future<Either<Failure, BaseResponse>> call() async => await _authRepository.logout();
}

