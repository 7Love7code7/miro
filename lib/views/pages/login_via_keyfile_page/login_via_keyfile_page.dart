import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/keyfile.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/widgets/kira_custom/kira_dropzone.dart';

class LoginViaKeyfilePage extends StatefulWidget {
  const LoginViaKeyfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginViaKeyfilePage();
}

class _LoginViaKeyfilePage extends State<LoginViaKeyfilePage> {
  final TextEditingController _keyfilePasswordController = TextEditingController(text: 'Some password');
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
        ],
      ),
    );
  }

  bool _validateKeyFile(String fileData) {
    try {
      _getWalletFromKeyFileString(fileData);
      return true;
    } catch (_) {
      return false;
    }
  }

  void _onLoginButtonPressed() {
    if (dropZoneController.hasUploads) {
      globalLocator<WalletProvider>().updateWallet(_getWalletFromKeyFileString(dropZoneController.fileData!));
      context.router.push(const DashboardRoute());
    }
  }

  Wallet _getWalletFromKeyFileString(String keyFileAsString) {
    KeyFile keyFile = KeyFile.fromFile(keyFileAsString, _keyfilePasswordController.text);
    return Wallet(
      networkInfo: keyFile.networkInfo,
      address: keyFile.address,
      privateKey: keyFile.privateKey,
      publicKey: keyFile.publicKey,
    );
  }
}
