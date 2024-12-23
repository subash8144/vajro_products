part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class ProfilePictureSelected extends LoginState {
  final File profileImage;

  const ProfilePictureSelected(this.profileImage);

  @override
  List<Object?> get props => [profileImage];
}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProfilePictureError extends LoginState {
  final String message;

  const ProfilePictureError({required this.message});

  @override
  List<Object?> get props => [message];
}