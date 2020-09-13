import 'package:goswapinfo/common/pair_liquidity.dart';
import 'package:goswapinfo/common/token.dart';
import 'package:goswapinfo/common/volume.dart';
import 'package:goswapinfo/common/pair_volume.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pair.dart';
import 'total.dart';

const bool prod = const bool.fromEnvironment('dart.vm.product');

class Api {
  static final String apiUrl = prod
      ? 'https://goswap-stats-xcefncm5jq-uc.a.run.app'
      : 'http://localhost:8080';

  static Future<List<Total>> fetchTotals() async {
    String url = apiUrl + '/totals';
    http.Response response;
    try {
      response = await http.get(url);
    } catch (err) {
      throw err;
    }
    if (response.statusCode != 200) {
      var e = ErrorResponse.parse(response);
      throw e;
    }
    try {
      final jsonmap = json.decode(response.body);
      final totals = jsonmap['overTime'];
      if (totals == null) return null;
      return List<Total>.from(totals.map((a) => Total.fromJson(a)));
    } catch (err) {
      throw err;
    }
  }

  static Future<List<Token>> fetchTokens() async {
    String url = apiUrl + '/tokens';
    http.Response response;
    try {
      response = await http.get(url);
    } catch (err) {
      throw err;
    }
    if (response.statusCode != 200) {
      var e = ErrorResponse.parse(response);
      throw e;
    }
    try {
      final jsonmap = json.decode(response.body);
      final tokens = jsonmap['tokens'];
      if (tokens == null) return null;
      return List<Token>.from(tokens.map((a) => Token.fromJson(a)));
    } catch (err) {
      throw err;
    }
  }

  static Future<List<Pair>> fetchPairs() async {
    String url = apiUrl + '/pairs';
    http.Response response;
    try {
      response = await http.get(url);
    } catch (err) {
      throw err;
    }
    if (response.statusCode != 200) {
      var e = ErrorResponse.parse(response);
      throw e;
    }
    try {
      final jsonmap = json.decode(response.body);
      print("jsonmap: $jsonmap");
      final tokens = jsonmap['pairs'];
      if (tokens == null) return null;
      return List<Pair>.from(tokens.map((a) => Pair.fromJson(a)));
    } catch (err) {
      throw err;
    }
  }

  static Future<List<Volume>> fetchVolume(String token) async {
    String url = apiUrl + '/tokens/' + token + '/volume';
    http.Response response;
    try {
      response = await http.get(url);
    } catch (err) {
      throw err;
    }
    if (response.statusCode != 200) {
      var e = ErrorResponse.parse(response);
      throw e;
    }
    try {
      final jsonmap = json.decode(response.body);
      final volume = jsonmap['overTime'];
      if (volume == null) return null;
      return List<Volume>.from(volume.map((a) => Volume.fromJson(a)));
    } catch (err) {
      throw err;
    }
  }

  static Future<List<PairVolume>> fetchPairVolume(String pair) async {
    String url = apiUrl + '/pairs/' + pair + '/volume';
    http.Response response;
    try {
      response = await http.get(url);
    } catch (err) {
      throw err;
    }
    if (response.statusCode != 200) {
      var e = ErrorResponse.parse(response);
      throw e;
    }
    try {
      final jsonmap = json.decode(response.body);
      final volume = jsonmap['overTime'];
      if (volume == null) return null;
      return List<PairVolume>.from(volume.map((a) => PairVolume.fromJson(a)));
    } catch (err) {
      throw err;
    }
  }

  static Future<List<PairLiquidity>> fetchPairLiquidity(String pair) async {
    String url = apiUrl + '/pairs/' + pair + '/liquidity';
    http.Response response;
    try {
      response = await http.get(url);
    } catch (err) {
      throw err;
    }
    if (response.statusCode != 200) {
      var e = ErrorResponse.parse(response);
      throw e;
    }
    try {
      final jsonmap = json.decode(response.body);
      final volume = jsonmap['overTime'];
      if (volume == null) return null;
      return List<PairLiquidity>.from(
          volume.map((a) => PairLiquidity.fromJson(a)));
    } catch (err) {
      throw err;
    }
  }
  //TODO:https://goswap-stats-xcefncm5jq-uc.a.run.app/tokens/WGO/liquidity - empty results as of now
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
