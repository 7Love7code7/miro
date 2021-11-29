import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/keyfile.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/browser_utils.dart';
import 'package:miro/views/widgets/kira_custom/kira_gravatar.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _keyfilePasswordController = TextEditingController(text: '');

    return Scaffold(
      body: Consumer<WalletProvider>(
        builder: (_, WalletProvider networkProvider, Widget? child) {
          final Wallet? _wallet = networkProvider.currentWallet;

          return Column(
            children: <Widget>[
              if (_wallet != null) ...<Widget>[
                Text(_wallet.bech32Address),
                KiraGravatar(address: _wallet.bech32Address),
                // KiraQrCode(data: _mnemonic.value),
                TextFormField(
                  controller: _keyfilePasswordController,
                ),
                ElevatedButton(
                  onPressed: () {
                    KeyFile keyfile = KeyFile.fromWallet(_wallet);
                    String encryptedKeyFileAsString =
                    keyfile.getFileContent(_keyfilePasswordController.text);
                    BrowserUtils.downloadFile(<String>[encryptedKeyFileAsString], keyfile.fileName);
                  },
                  child: const Text('Download keyfile'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.router.popUntilRoot();
                  },
                  child: const Text('Back to Welcome Page'),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
