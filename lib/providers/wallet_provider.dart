import 'package:flutter/material.dart';
import 'package:miro/shared/models/wallet.dart';

class WalletProvider extends ChangeNotifier {
  Wallet? _currentWallet;

  Wallet? get currentWallet {
    return _currentWallet;
  }

  void updateWallet(Wallet newWallet) {
    _currentWallet = newWallet;
    notifyListeners();
  }
  // Future<Wallet> createWallet(String mnemonic) async {}
}
