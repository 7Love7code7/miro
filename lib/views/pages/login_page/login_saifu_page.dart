import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/pages/login_page/saifu_qr_scanner_dialog.dart';
import 'package:miro/views/widgets/kira_custom/kira_toast.dart';

class LoginSaifuPage extends StatefulWidget {
  const LoginSaifuPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginSaifuPage();
}

class _LoginSaifuPage extends State<LoginSaifuPage> {
  String? errorMessage;
  bool isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (_) => SaifuQrScannerDialog(
                  qrCodeCallback: onReceiveQrCode,
                ),
              );
            },
            child: const Text('Scan QR'),
          ),
        ],
      ),
    );
  }

  void onReceiveQrCode(String mnemonicAsString) {
    login(mnemonicAsString);
  }

  Future<void> login(String mnemonicAsString) async {
    if (!isLoggingIn) {
      isLoggingIn = true;
      await Future<void>.delayed(const Duration(milliseconds: 500));

      try {
        Mnemonic mnemonic = Mnemonic(value: mnemonicAsString);
        Wallet wallet = Wallet.derive(mnemonic: mnemonic);
        globalLocator<WalletProvider>().updateWallet(wallet);
        await context.router.push(const DashboardRoute());
      } on InvalidMnemonicException catch (_) {
        KiraToast.show('Invalid mnemonic');
        errorMessage = 'Invalid mnemonic';
      } catch (_) {
        setState(() {
          errorMessage = 'Login error';
        });
      }
      isLoggingIn = false;
    }
  }
}
