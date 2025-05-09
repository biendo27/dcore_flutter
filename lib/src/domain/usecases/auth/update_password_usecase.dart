part of '../usecases.dart';

@lazySingleton
class UpdatePasswordUsecase implements UseCaseWithParams<Map<String, dynamic>, BaseResponse> {
  final IAuthRepository _authRepository;
  UpdatePasswordUsecase(this._authRepository);

  @override
  Future<Either<Failure, BaseResponse>> call(Map<String, dynamic> params) async => await _authRepository.updatePassword(params);
}



