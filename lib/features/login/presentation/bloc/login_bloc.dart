import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:products/features/login/domain/entities/login_entity.dart';
import 'package:products/features/login/domain/repositories/login_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<SelectProfilePicture>(_onProfileSelect);
    on<SubmitLogin>(_onSubmitLogin);
  }

  Future<void> _onProfileSelect(
      SelectProfilePicture event, Emitter<LoginState> emit) async {
    try {
      final status = await (event.source == ImageSource.camera
          ? Permission.camera.request()
          : Permission.photos.request());

      if (status.isGranted) {
        final picker = ImagePicker();
        final image = await picker.pickImage(source: event.source);
        if (image != null) {
          final savedImage = await _saveImageLocally(File(image.path));
          emit(ProfilePictureSelected(savedImage));
        }
      } else {
        emit(const ProfilePictureError(message: 'Permission denied.'));
      }
    } catch (e) {
      emit(ProfilePictureError(message: e.toString()));
    }
  }

  Future<File> _saveImageLocally(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/${image.path.split('/').last}';
    return image.copy(filePath);
  }

  Future<void> _onSubmitLogin(
      SubmitLogin event,
      Emitter<LoginState> emit,
      ) async {
    final result = await loginRepository.login(LoginEntity(email: event.email, password: event.password));
    result.fold(
          (failure) => emit(LoginFailure(message: failure.message)),
          (success) => emit(LoginSuccess()),
    );
  }
}