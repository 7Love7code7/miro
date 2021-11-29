import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/wallet/keyfile.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/browser_utils.dart';
import 'package:miro/views/pages/create_wallet_page/mnemonic_grid_tile.dart';
import 'package:miro/views/widgets/kira_custom/kira_gravatar.dart';
import 'package:miro/views/widgets/kira_custom/kira_qr_code.dart';

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateWalletPage();
}

class _CreateWalletPage extends State<CreateWalletPage> {
  final TextEditingController _keyfilePasswordController = TextEditingController(text: '');
  Mnemonic _mnemonic = Mnemonic.random();
  Wallet? _wallet;
  bool _isLoading = false;

  Map<String, dynamic> response = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          if (_wallet == null) ...<Widget>[
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _mnemonic = Mnemonic.random();
                });
              },
              child: const Text('Generate mnemonic'),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: _mnemonic.array.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return MnemonicGridTile(mnemonic: _mnemonic.array[index]);
                },
              ),
            ),
            SelectableText(
              _mnemonic.value,
            )
          ],
          if (_wallet != null) ...<Widget>[
            Text(_wallet!.bech32Address),
            KiraGravatar(address: _wallet!.bech32Address),
            KiraQrCode(data: _mnemonic.value),
            TextFormField(
              controller: _keyfilePasswordController,
            ),
            ElevatedButton(
              onPressed: () {
                KeyFile keyfile = KeyFile.fromWallet(_wallet!);
                String encryptedKeyFileAsString =
                keyfile.getFileContent(_keyfilePasswordController.text);
                BrowserUtils.downloadFile(<String>[encryptedKeyFileAsString], keyfile.fileName);
              },
              child: const Text('Download keyfile'),
            ),
          ],
          if (_isLoading) const Text('Generating...'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  context.router.pop();
                },
                child: const Text('Back to Welcome Page'),
              ),
              if (_wallet == null)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    Future<void>.delayed(const Duration(milliseconds: 500), () async {
                      Wallet newWallet = Wallet.derive(mnemonic: _mnemonic);
                      setState(() {
                        _wallet = newWallet;
                        _isLoading = false;
                      });
                    });
                  },
                  child: const Text('Create Account'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
