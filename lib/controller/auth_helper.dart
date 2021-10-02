import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart'
    show BuildContext, ChangeNotifier, debugPrint;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum AuthState {
  unknown,
  unauthorized,
  authorized,
}
enum AuthSource {
  email,
  apple,
  google,
}
final FirebaseAuth _authorization = FirebaseAuth.instance;

class StronksAuth extends ChangeNotifier {
  StronksAuth._();

  static final StronksAuth _instance = StronksAuth._();
  static StronksAuth get instance => _instance;
  static StronksAuth of(BuildContext context) {
    return Provider.of<StronksAuth>(context, listen: false);
  }

  FirebaseAuth get authorization => _authorization;

  /// this will give us a user object to work with if user is signed in,
  /// otherwise event fired is null
  Stream<User?> get userStream => authorization.userChanges();
  AuthState authorizedUser = AuthState.unknown;
  void getAuthStaus() {
    userStream.listen((event) {
      if (event != null) {
        authorizedUser = AuthState.authorized;
      } else {
        authorizedUser = AuthState.unauthorized;
      }
    });
    notifyListeners();
  }

  void reloadUser() => authorization.currentUser?.reload();
  void userSignOut() {
    authorization.signOut();
    reloadUser();
  }

  void userSignInEmailAndPW(String email, String password) => authorization
      .signInWithEmailAndPassword(email: email, password: password);

  void stronksSignIn(AuthSource authSource, String? email, String? password) {
    switch (authSource) {
      case AuthSource.email:
        try {
          userSignInEmailAndPW(email!, password!);
        } catch (e) {
          debugPrint(e.toString());
        }
        break;
      case AuthSource.google:
        try {
          signInWithGoogle();
        } catch (e) {
          debugPrint(e.toString());
        }
        break;
      case AuthSource.apple:
        try {
          signInWithApple();
        } catch (e) {
          debugPrint(e.toString());
        }
        break;
      default:
        _authFailed();
    }
    notifyListeners();
  }

////////////////
  ///APPLE SIGN IN
////////////////
  /// Generates a cryptographically secure random nonce, to be
  /// included in a credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

//////////////
  /// as apple above, so google below
/////////////

///////////////////////////
  /// GOOOGLE SIGN IN
///////////////////////////
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

Exception _authFailed() => Exception('stronks authorization failed');
