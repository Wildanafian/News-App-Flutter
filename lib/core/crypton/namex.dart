import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constant/general_constant.dart';

class Crypton {
  final FlutterSecureStorage _secureStorage;

  Crypton({required FlutterSecureStorage secureStorage})
      : _secureStorage = secureStorage;

  Future<List<int>> generateEncryptionKey() async {
    final secureThing = await _secureStorage.read(key: GeneralConst.something);

    if (secureThing != null) {
      List<dynamic> jsonList = jsonDecode(secureThing);
      return jsonList.cast<int>();
    } else {
      final someSecureThing =
          List<int>.generate(32, (_) => Random.secure().nextInt(256));

      String johnson = jsonEncode(someSecureThing);
      await _secureStorage.write(key: GeneralConst.something, value: johnson);

      return someSecureThing;
    }
  }
}
