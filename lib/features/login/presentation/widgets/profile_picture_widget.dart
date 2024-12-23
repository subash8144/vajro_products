import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/login_bloc.dart';

class ProfilePictureWidget extends StatefulWidget {
  const ProfilePictureWidget({super.key});

  @override
  State<ProfilePictureWidget> createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  Future<void> selectProfilePicture(BuildContext context) async {
    final bloc = context.read<LoginBloc>();
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Select from Gallery'),
            onTap: () {
              Navigator.of(context).pop();
              bloc.add(const SelectProfilePicture(source: ImageSource.gallery));
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take a Photo'),
            onTap: () {
              Navigator.of(context).pop();
              bloc.add(const SelectProfilePicture(source: ImageSource.camera));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => selectProfilePicture(context),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: state is ProfilePictureSelected
                ? FileImage(state.profileImage)
                : null,
            child: state is! ProfilePictureSelected
                ? const Icon(Icons.add_a_photo)
                : null,
          ),
        );
      },
    );
  }
}
