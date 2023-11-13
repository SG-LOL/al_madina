import 'package:al_madina_app/constent/rotues.dart';
import 'package:al_madina_app/services/auth/auth_service.dart';
import 'package:al_madina_app/views/logingview.dart';
import 'package:al_madina_app/views/complaintview.dart';
import 'package:al_madina_app/views/registerview.dart';
import 'package:al_madina_app/views/verfiyemail.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        complaintRoute: (context) => const complaintView(),
        verfiyEmailRoute: (context) => const VerfiyEmail(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user == null) {
              return const LoginView();
            } else if (user.isEmailVerified) {
              return const complaintView();
            } else {
              return const VerfiyEmail();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

Future<bool> showLogOut(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("sign out"),
        content: const Text("are you sure?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("cancel")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("sign out"))
        ],
      );
    },
  ).then((value) => value ?? false);
}
