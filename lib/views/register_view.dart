import 'package:flutter/material.dart';
import 'package:learningdart/services/auth/auth_exceptions.dart';
import 'package:learningdart/services/auth/auth_service.dart';
import 'package:learningdart/utlilites/dialogs/error_dialog.dart';
import '../constants/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Email Here',
                    ),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Password Here',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        await AuthService.firebase()
                            .createUser(email: email, password: password);
                        await AuthService.firebase().sendEmailVerification();
                        if (context.mounted) {
                          Navigator.of(context).pushNamed(verifyEmailRoute);
                        }
                      } on WeakPasswordAuthException {
                        if (!context.mounted) return;
                        await showErrorDialog(
                          context,
                          'Weak Password',
                        );
                      } on EmailAlreadyInUseAuthException {
                        if (!context.mounted) return;
                        await showErrorDialog(
                          context,
                          'Email Is Already In Use',
                        );
                      } on InvalidEmailAuthException {
                        if (!context.mounted) return;
                        await showErrorDialog(
                          context,
                          'The Email Is Invalid',
                        );
                      } on GenericAuthException {
                        if (!context.mounted) return;
                        await showErrorDialog(
                          context,
                          'Failed To Register',
                        );
                      }
                    },
                    child: const Text('Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (route) => false,
                      );
                    },
                    child: const Text('Already Registered? Login Here!'),
                  )
                ],
              );
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
