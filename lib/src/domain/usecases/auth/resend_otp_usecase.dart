part of '../usecases.dart';

@lazySingleton
class ResendOtpUsecase implements UseCaseWithParams<String, BaseResponse> {
  final IAuthRepository _authRepository;
  ResendOtpUsecase(this._authRepository);

  @override
  Future<Either<Failure, BaseResponse>> call(String params) async => await _authRepository.resendOTP(params);
}

