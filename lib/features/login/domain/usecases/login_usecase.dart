import 'package:dartz/dartz.dart';
import 'package:products/core/exception/app_exceptions.dart';
import 'package:products/features/login/domain/entities/login_entity.dart';
import 'package:products/features/login/domain/repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, bool>> call(LoginEntity entity) async {
    if (entity.email.isEmpty || entity.password.isEmpty) {
      return const Left(ServerFailure(message: "Email and Password cannot be empty."));
    }
    return await repository.login(LoginEntity(email: entity.email, password: entity.password));
  }
}