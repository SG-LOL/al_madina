// ignore_for_file: use_build_context_synchronously

import 'package:al_madina_app/constent/rotues.dart';
import 'package:al_madina_app/services/auth/auth_exception.dart';
import 'package:al_madina_app/services/auth/auth_service.dart';
import 'package:al_madina_app/utlilties/show_error_dailog.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController email;
  late final TextEditingController password;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("register"),
      ),
      body: Column(
        children: [
          TextField(
            controller: email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "enter your email"),
          ),
          TextField(
            controller: password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: "enter your password"),
          ),
          TextButton(
            onPressed: () async {
              final eEmail = email.text;
              final pPassword = password.text;
              try {
                await AuthService.firebase().createUser(
                  email: eEmail,
                  password: pPassword,
                );
                await AuthService.firebase().sendEmailVerification();

                Navigator.of(context).pushNamed(verfiyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialo(
                  context,
                  "weak password",
                );
              } on EmailAlreadyInUseAuthException {
                await showErrorDialo(
                  context,
                  "email already in use",
                );
              } on InavlidEmailAuthException {
                await showErrorDialo(
                  context,
                  "invalid email ",
                );
              } on GenericAuthException {
                await showErrorDialo(context, "error:");
              }
            },
            child: const Text("register"),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
              child: const Text("already registered? login here"))
        ],
      ),
    );
  }
}
