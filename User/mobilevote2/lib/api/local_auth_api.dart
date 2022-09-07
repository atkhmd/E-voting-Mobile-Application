import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      // ignore: deprecated_member_use
      return await _auth.authenticateWithBiometrics(
        androidAuthStrings: const AndroidAuthMessages(
          signInTitle: 'Face ID Required',
        ),
        localizedReason: "Scan face to authenticate",
        useErrorDialogs: true,
        stickyAuth: false,
      );
    } on PlatformException {
      return false;
    }
  }
}
