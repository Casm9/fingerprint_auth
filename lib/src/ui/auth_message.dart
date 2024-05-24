import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/auth_bloc.dart';

class AuthMessage extends StatelessWidget {
  const AuthMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthBloc>(
      builder: (context, bloc, _) => Text(
        bloc.authorized,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
