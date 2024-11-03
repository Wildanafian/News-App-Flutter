import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';

class LoggerInterceptor extends InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    if (kDebugMode) {
      log('--------------- Request ---------------');
      log(request.toString());
      log(request.headers.toString());
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    if (kDebugMode) {
      log('--------------- Response ---------------');
      log('Code: ${response.statusCode}');
      if (response is Response) {
        log((response).body);
      }
    }
    return response;
  }
}
