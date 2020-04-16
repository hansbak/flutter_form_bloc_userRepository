import 'dart:async';

import 'package:meta/meta.dart';

class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    print("repository authenticate");
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<void> deleteToken() async {
    print("repository delete token");
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    print("repository persist token: $token");
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<String> getToken() async {
    print("repository has token");
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return 'tokenValue';
  }
}
