import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/keyfile.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/widgets/kira_custom/kira_dropzone.dart';

class LoginKeyfilePage extends StatefulWidget {
  const LoginKeyfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginKeyfilePage();
}

class _LoginKeyfilePage extends State<LoginKeyfilePage> {
  final TextEditingController _keyfilePasswordController = TextEditingController(text: '');
  KiraDropZoneController dropZoneController = KiraDropZoneController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          KiraDropzone(
            controller: dropZoneController,
            validate: _validateKeyFile,
          ),
          TextFormField(
            controller: _keyfilePasswordController,
          ),
          ElevatedButton(
            onPressed: _onLoginButtonPressed,
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

  String? _validateKeyFile(String fileData) {
    try {
      _getWalletFromKeyFileString(fileData);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  void _onLoginButtonPressed() {
    if (dropZoneController.hasUploads) {
      globalLocator<WalletProvider>().updateWallet(_getWalletFromKeyFileString(dropZoneController.fileData!));
      context.router.push(const DashboardRoute());
    }
  }

  Wallet _getWalletFromKeyFileString(String keyFileAsString) {
    try {
      KeyFile keyFile = KeyFile.fromFile(keyFileAsString, _keyfilePasswordController.text);
      return Wallet(
        networkInfo: keyFile.networkInfo,
        address: keyFile.address,
        privateKey: keyFile.privateKey,
        publicKey: keyFile.publicKey,
      );
    } catch (_) {
      throw Exception('Invalid keyfile or wrong password');
    }
  }
}
