import 'dart:html';

import 'package:flutter/material.dart';
import 'package:miro/shared/models/network_model.dart';

class NetworkProvider extends ChangeNotifier {
  NetworkModel? _currentNetwork;

  NetworkModel? get currentNetwork => _currentNetwork;

  bool get isConnected => _currentNetwork != null;

  String? get networkUrl {
    if (isConnected) {
      return _currentNetwork!.url;
    }
    return null;
  }

  void changeCurrentNetwork(NetworkModel? newNetwork) {
    _currentNetwork = newNetwork;
    _updateUrlParams(newNetwork);
    notifyListeners();
  }

  void _updateUrlParams(NetworkModel? newNetwork) {
    Uri currentUrl = Uri.base;
    currentUrl = currentUrl.replace(queryParameters: <String, dynamic>{
      'rpc': newNetwork != null ? newNetwork.parsedUri.toString() : '',
    });
    window.history.replaceState(<String, dynamic>{}, '', currentUrl.toString());
  }
}
