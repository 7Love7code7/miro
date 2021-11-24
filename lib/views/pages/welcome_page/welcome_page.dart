import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/router/router.gr.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              context.router.navigate(
                const ConnectionRoute(),
              );
            },
            child: const Text('Navigate to Connection Screen'),
          ),
          ElevatedButton(
            onPressed: () {
              context.router.navigate(
                const CreateWalletRoute(),
              );
            },
            child: const Text('Navigate to Create Wallet Page'),
          ),
          ElevatedButton(
            onPressed: () {
              context.router.navigate(
                const LoginViaKeyfileRoute(),
              );
            },
            child: const Text('Navigate to Login Page - KEYFILE'),
          ),
          ElevatedButton(
            onPressed: () {
              context.router.navigate(
                const LoginViaMnemonicRoute(),
              );
            },
            child: const Text('Navigate to Login Page - MNEMONIC'),
          ),
          ElevatedButton(
            onPressed: () {
              context.router.navigate(
                const LoginViaSaifuRoute(),
              );
            },
            child: const Text('Navigate to Login Page - SAIFU'),
          ),
        ],
      ),
    );
  }
}
