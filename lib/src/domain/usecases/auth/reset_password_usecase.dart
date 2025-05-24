part of '../usecases.dart';

@lazySingleton
class ResetPasswordUsecase implements UseCaseWithParams<Map<String, dynamic>, BaseResponse> {
  final IAuthRepository _authRepository;
  ResetPasswordUsecase(this._authRepository);

  @override
  Future<Either<Failure, BaseResponse>> call(Map<String, dynamic> params) async => await _authRepository.resetPassword(params);
}

