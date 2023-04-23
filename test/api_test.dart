import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:g2railtest/api/g2rail_api_client.dart';
import 'package:http/http.dart' as http;

void main() {
  test("search api", () async {
    var client = GrailApiClient(
      baseUrl: "http://alpha.api.g2rail.com",
      apiKey: "{apiKey}",
      secret: "{secret}",
      httpClient: http.Client(),
    );

    var solution = await client.getSolutions(
        "ST_D1297OY2", "ST_LV5236GZ", "2023-04-24", "10:00", 2, 0);
    String rtn = solution["async"];
    debugPrint(rtn);

    var rtn2 = await client.getAsyncResult(rtn);
    debugPrint(rtn2.toString());
  });
}
