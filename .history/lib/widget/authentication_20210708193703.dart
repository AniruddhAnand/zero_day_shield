import 'package:local_auth/local_auth.dart';

class Authentication {
  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticateWithBiometrics(
        localizedReason: 'Please complete the biometrics to proceed.',
      );
    }

    return isAuthenticated;
  }
  
  void authorize() async{
    bool isAuthenticated = await Authentication.authenticateWithBiometrics();
    if (isAuthenticated) {
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new ScrollScreen(_pwds),
        ),
      );
    }
  }
}