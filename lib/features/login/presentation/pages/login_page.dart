import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/core/constants/app_constants.dart';
import 'package:products/core/routes/app_router.dart';
import 'package:products/core/utils/validators.dart';
import 'package:products/features/login/data/repositories/login_repository_impl.dart';
import '../bloc/login_bloc.dart';
import '../widgets/profile_picture_widget.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class LoginPage extends StatefulWidget {

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(AppConstants.vLogo),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocProvider(
                  create: (_) =>
                      LoginBloc(loginRepository: LoginRepositoryImpl()),
                  child: BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        context.router.replace(const HomeRoute());
                      } else if (state is LoginFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ProfilePictureWidget(),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                suffixIcon: Icon(
                                  Icons.email_outlined,
                                ),
                              ),
                              validator: Validators.emailValidator,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscure,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscure = !_obscure; // Toggle obscureText state
                                    });
                                  },
                                ),
                              ),
                              validator: Validators.passwordValidator,

                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<LoginBloc>().add(SubmitLogin(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ));
                                }
                              },
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}