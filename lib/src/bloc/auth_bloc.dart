import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../services/auth_service.dart';

class AuthBloc extends ChangeNotifier {
  final AuthService _authService;

  AuthBloc(this._authService);

  bool _canCheckBiometric = false;
  List<BiometricType> _availableBiometrics = [];
  String _authorized = "Not authorized";

  bool get canCheckBiometric => _canCheckBiometric;

  List<BiometricType> get availableBiometrics => _availableBiometrics;

  String get authorized => _authorized;

  Future checkBiometric() async {
    _canCheckBiometric = await _authService.canCheckBiometrics();
    notifyListeners();
  }

  Future getAvailableBiometric() async {
    _availableBiometrics = await _authService.getAvailableBiometrics();
    notifyListeners();
  }

  Future authenticate(String authMessage, VoidCallback onSuccess) async {
    final authenticated =
        await _authService.authenticate(localizedReason: authMessage);
    _authorized =
        authenticated ? "Authorized success" : "Failed to authenticate";
    if (authenticated) {
      onSuccess();
    }
    notifyListeners();
  }
}
