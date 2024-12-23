import 'package:dartz/dartz.dart';
import 'package:products/core/api/api_service.dart';
import 'package:products/core/exception/app_exceptions.dart';
import 'package:products/features/login/domain/entities/login_entity.dart';
import 'package:products/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<Either<Failure, bool>> login(LoginEntity entity) async {
    const hardcodedEmail = "user@example.com";
    const hardcodedPassword = "Password@123";

    if (entity.email == hardcodedEmail && entity.password == hardcodedPassword) {
      return const Right(true);
    } else {
      return const Left(ServerFailure(message: "Invalid email or password."));
    }
  }
}