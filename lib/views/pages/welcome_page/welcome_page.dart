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
                const LoginKeyfileRoute(),
              );
            },
            child: const Text('Navigate to Login Page - KEYFILE'),
          ),
          ElevatedButton(
            onPressed: () {
              context.router.navigate(
                const LoginMnemonicRoute(),
              );
            },
            child: const Text('Navigate to Login Page - MNEMONIC'),
          ),
          ElevatedButton(
            onPressed: () {
              context.router.navigate(
                const LoginSaifuRoute(),
              );
            },
            child: const Text('Navigate to Login Page - SAIFU'),
          ),
        ],
      ),
    );
  }
}
