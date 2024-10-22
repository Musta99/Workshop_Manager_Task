import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  // =========== Sign up Authentication ============ //
  Future signupFirebaseAuth(email, password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // =========== Log in Authentication ============ //
  Future loginFirebaseAuth(email, password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // =========== Log out Authentication ============ //
  Future logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
