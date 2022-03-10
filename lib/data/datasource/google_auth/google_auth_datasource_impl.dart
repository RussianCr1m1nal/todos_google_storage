import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todos_google_storage/data/datasource/google_auth/google_auth_datasource.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: GoogleAuthDataSource)
class GoogleAuthDataSourceImpl extends GoogleAuthDataSource {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;

  @override
  Future<void> googleLogin() async {
    _currentUser = await googleSignIn.signIn();

    if (_currentUser == null) {
      return;
    }

    final googleAuth = await _currentUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<GoogleSignInAccount?> getUser() async {
    return _currentUser;
  }

  @override
  Future<void> googleLogOut() async {
    _currentUser = await googleSignIn.signOut();
  }
}
