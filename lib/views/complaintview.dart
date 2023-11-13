// ignore_for_file: use_build_context_synchronously, camel_case_types

import 'package:al_madina_app/enums/menu_action.dart';
import 'package:al_madina_app/main.dart';
import 'package:flutter/material.dart';
import 'package:al_madina_app/constent/rotues.dart';
import 'package:al_madina_app/services/auth/auth_service.dart';

class complaintView extends StatefulWidget {
  const complaintView({super.key});

  @override
  State<complaintView> createState() => _complaintViewState();
}

class _complaintViewState extends State<complaintView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("complaint"),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOut(context);
                if (shouldLogout) {
                  await AuthService.firebase().logOut();

                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                }
            }
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                  value: MenuAction.logout, child: Text("log out"))
            ];
          })
        ],
      ),
      body: const Text("hello world"),
    );
  }
}
