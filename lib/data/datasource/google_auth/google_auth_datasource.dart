import 'package:google_sign_in/google_sign_in.dart';

abstract class GoogleAuthDataSource {
  Future<void> googleLogin();
  Future<GoogleSignInAccount?> getUser();
  Future<void> googleLogOut();
}
