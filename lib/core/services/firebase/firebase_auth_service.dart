import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Get user id
  String getUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  // Sign in with email and password
  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return credential.user!;
  }

  // Sign up with Email and password
  Future<User> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await verifyEmail(); //! After user sign up, send verify email
    return credential.user!;
  }

  // Sign in with Google
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return (await firebaseAuth.signInWithCredential(credential)).user!;
  }

  // Forgot password
  Future<void> sendPasswordResetEmail(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Verify Email
  Future<void> verifyEmail() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
  }

  // Log out
  Future<void> signOut() async {
    await GoogleSignIn().disconnect();
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
  }

  Future<bool> isUserLoggedIn() async {
    final user = firebaseAuth.currentUser;

    if (user != null) {
      // The user is logged in, now check if the email is verified
      return await checkEmailVerification();
    } else {
      // The user is not logged in
      return false;
    }
  }

  Future<bool> checkEmailVerification() async {
    final user = firebaseAuth.currentUser;
    // If the email is already verified, no need to reload
    if (user!.emailVerified) {
      return true;
    }

    // Reload the user data to ensure we have the latest email verification status
    await user.reload();
    // Return the updated emailVerified status
    return user.emailVerified;
  }

  Future<void> deleteAccount() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      await user.delete();
    }
  }
}
