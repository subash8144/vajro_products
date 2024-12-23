import 'package:dartz/dartz.dart';
import 'package:products/core/exception/app_exceptions.dart';
import 'package:products/features/login/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, bool>> login(LoginEntity entity);
}