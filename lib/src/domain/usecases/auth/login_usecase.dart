part of '../usecases.dart';

@lazySingleton
class LoginUsecase implements UseCaseWithParams<Map<String, dynamic>, BaseResponse<Auth>> {
  final IAuthRepository _authRepository;
  LoginUsecase(this._authRepository);

  @override
  Future<Either<Failure, BaseResponse<Auth>>> call(Map<String, dynamic> params) async => _authRepository.login(params);
}

