import 'package:local_auth/local_auth.dart';

class AuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await auth.getAvailableBiometrics();
  }

  Future<bool> authenticate({required String localizedReason}) async {
    return await auth.authenticate(
      localizedReason: localizedReason,
      options:
          const AuthenticationOptions(useErrorDialogs: true, stickyAuth: false),
    );
  }
}
