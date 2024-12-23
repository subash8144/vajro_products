part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class SubmitLogin extends LoginEvent {
  final String email;
  final String password;

  const SubmitLogin({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SelectProfilePicture extends LoginEvent {
  final ImageSource source;

  const SelectProfilePicture({required this.source});

  @override
  List<Object?> get props => [source];
}