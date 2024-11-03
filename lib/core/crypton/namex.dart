import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constant/general_constant.dart';
import '../di/main_dependency_injection.dart';

Future<List<int>> generateEncryptionKey() async {
  final FlutterSecureStorage secureStorage = di<FlutterSecureStorage>();

  final secureThing = await secureStorage.read(key: GeneralConst.something);

  if (secureThing != null) {
    List<dynamic> jsonList = jsonDecode(secureThing);
    return jsonList.cast<int>();
  } else {
    final someSecureThing =
        List<int>.generate(32, (_) => Random.secure().nextInt(256));

    String johnson = jsonEncode(someSecureThing);
    await secureStorage.write(key: GeneralConst.something, value: johnson);

    return someSecureThing;
  }
}
