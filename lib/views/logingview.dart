// ignore_for_file: use_build_context_synchronously

import 'package:al_madina_app/constent/rotues.dart';
import 'package:al_madina_app/services/auth/auth_exception.dart';
import 'package:al_madina_app/services/auth/auth_service.dart';
import 'package:al_madina_app/utlilties/show_error_dailog.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("login"),
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
                await AuthService.firebase().logIn(
                  email: eEmail,
                  password: pPassword,
                );
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    complaintRoute,
                    (route) => false,
                  );
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verfiyEmailRoute,
                    (route) => false,
                  );
                }
              } on UserNotFoundException {
                await showErrorDialo(
                  context,
                  "user not found",
                );
              } on WrongPasswordAuthException {
                await showErrorDialo(
                  context,
                  "wrong password",
                );
              } on GenericAuthException {
                await showErrorDialo(
                  context,
                  "error",
                );
              }
            },
            child: const Text("login"),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text("register now"))
        ],
      ),
    );
  }
}
