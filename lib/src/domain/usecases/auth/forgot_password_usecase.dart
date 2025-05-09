part of '../usecases.dart';

@lazySingleton
class ForgotPasswordUsecase implements UseCaseWithParams<Map<String, dynamic>, BaseResponse<Auth>> {
  final IAuthRepository _authRepository;
  ForgotPasswordUsecase(this._authRepository);

  @override
  Future<Either<Failure, BaseResponse<Auth>>> call(Map<String, dynamic> params) async => _authRepository.forgotPassword(params);
}

