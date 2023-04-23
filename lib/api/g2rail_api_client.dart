import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchCriteria {
  final String from;
  final String to;
  final String date;
  final String time;
  final int adult;
  final int child;

  SearchCriteria(
      {required this.from,
      required this.to,
      required this.date,
      required this.time,
      required this.adult,
      required this.child});

  String toQuery() {
    return "from=$from&to=$to&date=$date&time=$time&adult=$adult&child=$child";
  }

  Map<String, dynamic> toMap() {
    return {
      "from": from,
      "to": to,
      "date": date,
      "time": time,
      "adult": adult,
      "child": child
    };
  }
}

class GrailApiClient {
  final String baseUrl;
  final String apiKey;
  final String secret;
  final http.Client httpClient;

  GrailApiClient(
      {required this.baseUrl,
      required this.apiKey,
      required this.secret,
      required this.httpClient});

  Map<String, String> getAuthorizationHeaders(Map<String, dynamic> params) {
    var timestamp = DateTime.now();
    params['t'] = (timestamp.millisecondsSinceEpoch ~/ 1000).toString();
    params['api_key'] = apiKey;

    var sortedKeys = params.keys.toList()..sort((a, b) => a.compareTo(b));
    StringBuffer buffer = StringBuffer("");
    for (var key in sortedKeys) {
      if (params[key] is List || params[key] is Map) continue;
      buffer.write('$key=${params[key].toString()}');
    }
    buffer.write(secret);

    String hashString = buffer.toString();
    String authorization = md5.convert(utf8.encode(hashString)).toString();

    return {
      "From": apiKey,
      "Content-Type": 'application/json',
      "Authorization": authorization,
      "Date": HttpDate.format(timestamp),
      "Api-Locale": "zh-TW"
    };
  }

  Future<dynamic> getSolutions(String from, String to, String date, String time,
      int adult, int child) async {
    final criteria = SearchCriteria(
        from: from, to: to, date: date, time: time, adult: adult, child: child);
    final solutionUrl =
        '$baseUrl/api/v2/online_solutions/?${criteria.toQuery()}';

    final solutionResponse = await httpClient.get(Uri.parse(solutionUrl),
        headers: getAuthorizationHeaders(criteria.toMap()));

    if (solutionResponse.statusCode != 200) {
      throw Exception('error getting solutions');
    }

    final solutionsJson = jsonDecode(solutionResponse.body);
    debugPrint(solutionResponse.body);
    return solutionsJson;
  }

  Future<dynamic> getAsyncResult(String asyncKey, {int retryCounts = 3}) async {
    if (retryCounts == 0) {
      return {
        "data": {
          "description": "Async Result not ready",
          "code": "async_not_ready"
        }
      };
    }
    final asyncResultURl = '$baseUrl/api/v2/async_results/$asyncKey';
    final asyncResult = await httpClient.get(Uri.parse(asyncResultURl),
        headers: getAuthorizationHeaders({"async_key": asyncKey}));

    var rtn = jsonDecode(utf8.decode(asyncResult.bodyBytes));
    if (rtn.toString().contains("async_not_ready") ||
        rtn.toString().contains("系统繁忙")) {
      debugPrint("$retryCounts:$rtn");
      return await Future.delayed(const Duration(seconds: 10), () {
        //秒數可以依需求修改

        return getAsyncResult(asyncKey, retryCounts: retryCounts -= 1);
      });
    } else {
      return {"data": jsonDecode(utf8.decode(asyncResult.bodyBytes))};
    }
  }
}
