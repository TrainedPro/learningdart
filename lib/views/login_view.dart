import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningdart/services/auth/auth_exceptions.dart';
import 'package:learningdart/services/auth/bloc/auth_bloc.dart';
import 'package:learningdart/services/auth/bloc/auth_event.dart';
import 'package:learningdart/utlilites/dialogs/error_dialog.dart';

import '../constants/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text('Login'),
      ),
      body: Column(
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
                context.read<AuthBloc>().add(
                      AuthEventLogIn(
                        email,
                        password,
                      ),
                    );
              } on UserNotFoundAuthException {
                if (!context.mounted) return;
                await showErrorDialog(context, 'User Not Found');
              } on WrongPasswordAuthException {
                if (!context.mounted) return;
                await showErrorDialog(context, 'Your Password Is Incorrect!');
              } on GenericAuthException {
                if (!context.mounted) return;
                await showErrorDialog(context, 'Authentication Error');
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Not Registered Yet? Register Here!'),
          ),
        ],
      ),
    );
  }
}
