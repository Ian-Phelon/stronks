import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show ChangeNotifier, BuildContext;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'apple_sign_in.dart';
part 'google_sign_in.dart';

class StronksAuth extends ChangeNotifier {
  StronksAuth._();

  static final StronksAuth _instance = StronksAuth._();
  static StronksAuth get instance => _instance;
  static StronksAuth of(BuildContext context) {
    return Provider.of<StronksAuth>(context, listen: false);
  }
}

class StronksUser {
  final String? userName;
  final String? email;
  StronksUser(this.userName, this.email);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StronksUser &&
        other.userName == userName &&
        other.email == email;
  }

  @override
  int get hashCode => userName.hashCode ^ email.hashCode;
}
