// ignore_for_file: use_build_context_synchronously

import 'package:al_madina_app/constent/rotues.dart';
import 'package:al_madina_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class VerfiyEmail extends StatefulWidget {
  const VerfiyEmail({super.key});

  @override
  State<VerfiyEmail> createState() => _VerfiyEmailState();
}

class _VerfiyEmailState extends State<VerfiyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('verfiy email'),
      ),
      body: Column(
        children: [
          const Text("we have sent you an email"),
          const Text("resend the email"),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text("send email"),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text("restart"),
          )
        ],
      ),
    );
  }
}
