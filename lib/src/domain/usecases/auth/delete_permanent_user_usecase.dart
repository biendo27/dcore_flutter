part of '../usecases.dart';

@lazySingleton
class DeletePermanentUserUsecase implements UseCaseWithParams<String, BaseResponse> {
  final IAuthRepository _authRepository;
  DeletePermanentUserUsecase(this._authRepository);

  @override
  Future<Either<Failure, BaseResponse>> call(String params) async => _authRepository.deletePermanentUser(params);
}

