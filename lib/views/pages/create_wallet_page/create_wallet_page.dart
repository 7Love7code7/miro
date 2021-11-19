import 'package:bip39/bip39.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/default_networks_list.dart';
import 'package:miro/shared/models/keyfile.dart';
import 'package:miro/shared/models/mnemonic.dart';
import 'package:miro/shared/models/wallet.dart';
import 'package:miro/views/pages/create_wallet_page/mnemonic_grid_tile.dart';
import 'package:miro/views/widgets/kira_custom/kira_gravatar.dart';
import 'package:miro/views/widgets/kira_custom/kira_qr_code.dart';

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateWalletPage();
}

class _CreateWalletPage extends State<CreateWalletPage> {
  late Mnemonic _mnemonic;
  Wallet? _wallet;
  bool _isLoading = false;

  Map<String, dynamic> response = <String, dynamic>{};

  @override
  void initState() {
    _mnemonic = _generateMnemonic();
    super.initState();
  }

  Mnemonic _generateMnemonic() {
    return Mnemonic(value: generateMnemonic(strength: 256));
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
                  _mnemonic = _generateMnemonic();
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
          ],
          if (_wallet != null) ...<Widget>[
            Text(_wallet!.bech32Address),
            KiraGravatar(address: _wallet!.bech32Address),
            KiraQrCode(data: _mnemonic.value),
            ElevatedButton(
              onPressed: () {
                KeyFile.fromWallet(_wallet!).download();
              },
              child: const Text('Download keyfile'),
            ),
          ],
          if (_isLoading) const Text('Generating...'),
          if (_wallet == null)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                Future<void>.delayed(const Duration(milliseconds: 500), () async {
                  Wallet newWallet = Wallet.derive(_mnemonic, defaultNetwork);
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
    );
  }
}
