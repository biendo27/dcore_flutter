part of '../usecases.dart';

@lazySingleton
class RegisterUsecase implements UseCaseWithParams<Map<String, dynamic>, BaseResponse<Auth>> {
  final IAuthRepository _authRepository;
  RegisterUsecase(this._authRepository);

  @override
  Future<Either<Failure, BaseResponse<Auth>>> call(Map<String, dynamic> params) async => _authRepository.register(params);
}

