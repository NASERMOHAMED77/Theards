import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firee/core/utils/local_shared_pref.dart';
import 'package:firee/features/login_screen/data/repo/login_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';

class X implements LoginRepo {
  @override
  void loginByGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    var newUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email.toString());

    newUser.set({
      'image': FirebaseAuth.instance.currentUser!.photoURL.toString(),
      'name': FirebaseAuth.instance.currentUser!.displayName.toString(),
      'email': FirebaseAuth.instance.currentUser!.email.toString(),
      'id': FirebaseAuth.instance.currentUser!.uid.toString()
    });
    CacheLocal.insertDataIntoCache(
        key: 'token', value: FirebaseAuth.instance.currentUser!.email.toString());
    FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<UserCredential> logoutfromGoogle() {
    throw UnimplementedError();
  }
}
