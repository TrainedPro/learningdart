import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learningdart/firebase_options.dart';
import 'package:learningdart/utlilites/show_error_dialog.dart';

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
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
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
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        final user = FirebaseAuth.instance.currentUser;
                        await user?.sendEmailVerification();
                        if (context.mounted) {
                          Navigator.of(context).pushNamed(verifyEmailRoute);
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          await showErrorDialog(
                            context,
                            'Weak Password',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          await showErrorDialog(
                            context,
                            'Email Is Already In Use',
                          );
                        } else if (e.code == 'invalid-email') {
                          await showErrorDialog(
                            context,
                            'The Email Is Invalid',
                          );
                        } else {
                          await showErrorDialog(
                            context,
                            'Error: ${e.code}',
                          );
                        }
                      } catch (e) {
                        await showErrorDialog(context, 'External Error: $e');
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
