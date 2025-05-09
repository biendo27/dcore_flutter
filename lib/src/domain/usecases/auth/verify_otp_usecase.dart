part of '../usecases.dart';

@lazySingleton
class VerifyOtpUsecase implements UseCaseWithParams<Map<String, dynamic>, BaseResponse<AppUser>> {
  final IAuthRepository _authRepository;
  VerifyOtpUsecase(this._authRepository);

  @override
  Future<Either<Failure, BaseResponse<AppUser>>> call(Map<String, dynamic> params) async => await _authRepository.verifyOTP(params);
}

