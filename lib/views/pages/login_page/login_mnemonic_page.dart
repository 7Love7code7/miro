import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/router/router.gr.dart';

class LoginMnemonicPage extends StatefulWidget {
  const LoginMnemonicPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginMnemonicPage();
}

class _LoginMnemonicPage extends State<LoginMnemonicPage> {
  final TextEditingController mnemonicTextController = TextEditingController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextFormField(
            controller: mnemonicTextController,
          ),
          ElevatedButton(
            onPressed: onLoginButtonPressed,
            child: const Text('Login'),
          ),
          ElevatedButton(
            onPressed: () {
              context.router.pop();
            },
            child: const Text('Back to Welcome Page'),
          ),
        ],
      ),
    );
  }

  Future<void> onLoginButtonPressed() async {
    // Complete all UI operations before heavy Wallet deriving
    await Future<void>.delayed(const Duration(milliseconds: 500));

    try {
      Mnemonic mnemonic = Mnemonic(value: mnemonicTextController.text);
      Wallet wallet = Wallet.derive(mnemonic: mnemonic);
      globalLocator<WalletProvider>().updateWallet(wallet);
      await context.router.push(const DashboardRoute());
    } on InvalidMnemonicException catch (_) {
      errorMessage = 'Invalid mnemonic';
    } catch (_) {
      setState(() {
        errorMessage = 'Login error';
      });
    }
  }
}
