import 'package:http/http.dart' as http;
import 'dart:convert';
import 'totals.dart';

class Api {
  static final String apiUrl =
      'https://goswap-stats-xcefncm5jq-uc.a.run.app/totals';
  static Future<List<Total>> fetchTotals() async {
    String url = apiUrl;
    http.Response response;
    try {
      response = await http.get(url);
    } catch (err) {
      throw err;
    }
    if (response.statusCode != 200) {
      if (response.statusCode == 404) return Future.value(null);
      var e = ErrorResponse.parse(response);
      throw e;
    }
    try {
      final jsonmap = json.decode(response.body);
      final totals = jsonmap['overTime'];
      if (totals == null) return null;
      return List<Total>.from(totals.map((a) => Total.fromJson(a)));
    } catch (err) {
      print("ERROR decoding json: $err");
      throw err;
    }
  }
}

class ErrorResponse {
  int code;
  String message;

  ErrorResponse({int code, String message})
      : this.code = code,
        this.message = message;

  ErrorResponse.parse(http.Response response)
      : code = response.statusCode,
        message = _message(response.body);

  String format() {
    return 'Error ($code): $message';
  }

  String toString() {
    return format();
  }

  static String _message(String body) {
    if (body == null) return null;
    try {
      return json.decode(body)['error']['message'];
    } catch (_) {
      return body;
    }
  }
}
