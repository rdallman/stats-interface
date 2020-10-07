import 'package:goswapinfo/common/token.dart';
import 'package:goswapinfo/common/volume.dart';
import 'package:goswapinfo/common/pair_volume.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pair.dart';
import 'total.dart';

const bool prod = const bool.fromEnvironment('dart.vm.product');

class Api {
  // static final String apiUrl = 'https://goswap-stats-xcefncm5jq-uc.a.run.app';

  static final String apiUrl = 'https://stats-api.goswap.exchange';

  static String rfc3339(DateTime dt) {
    return dt.toUtc().toIso8601String();
  }

  static Future<List<Total>> fetchTotals() async {
    DateTime now = DateTime.now();
    DateTime dStart = now.subtract(Duration(days: 60));
    String url =
        "$apiUrl/totals?start_time=${rfc3339(dStart)}&end_time=${rfc3339(now)}&interval=1440h";
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
    DateTime now = DateTime.now();
    DateTime dStart = now.subtract(Duration(hours: 24));
    String url =
        "$apiUrl/tokens?start_time=${rfc3339(dStart)}&end_time=${rfc3339(now)}&interval=24h";
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
      // print("jsonmap: $jsonmap");
      final tokens = jsonmap['tokens'];
      if (tokens == null) return null;
      return List<Token>.from(tokens.map((a) {
        var t = Token.fromJson(a);
        t.stats = TokenBucket.fromJson(jsonmap['stats'][t.address]);
        return t;
      }));
    } catch (err, stack) {
      print(err);
      print(stack);
      throw err;
    }
  }

  static Future<List<Pair>> fetchPairs() async {
    DateTime now = DateTime.now();
    DateTime dStart = now.subtract(Duration(hours: 24));
    String url =
        "$apiUrl/pairs?start_time=${rfc3339(dStart)}&end_time=${rfc3339(now)}&interval=24h";
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
      // print("jsonmap: $jsonmap");
      final tokens = jsonmap['pairs'];
      final stats = jsonmap['stats'];
      // print("STATS XXX: $stats");
      if (tokens == null) return null;
      return List<Pair>.from(tokens.map((a) {
        var p = Pair.fromJson(a);
        // print("ADDRESS: ${p.address}");
        var s = stats[p.address];
        // print("STATS: $s");
        p.stats = PairBucket.fromJson(s);
        return p;
      }));
    } catch (err, stack) {
      print(err);
      print(stack);
      throw err;
    }
  }

  static Future<List<TokenBucket>> fetchTokenBuckets(String token) async {
    String url = apiUrl + '/tokens/' + token + '/buckets';
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
      final volume = jsonmap['buckets'];
      if (volume == null) return null;
      return List<TokenBucket>.from(volume.map((a) => TokenBucket.fromJson(a)));
    } catch (err) {
      throw err;
    }
  }

  // static Future<List<PairVolume>> fetchPairVolume(String pair) async {
  //   String url = apiUrl + '/pairs/' + pair + '/volume';
  //   http.Response response;
  //   try {
  //     response = await http.get(url);
  //   } catch (err) {
  //     throw err;
  //   }
  //   if (response.statusCode != 200) {
  //     var e = ErrorResponse.parse(response);
  //     throw e;
  //   }
  //   try {
  //     final jsonmap = json.decode(response.body);
  //     final volume = jsonmap['overTime'];
  //     if (volume == null) return null;
  //     return List<PairVolume>.from(volume.map((a) => PairVolume.fromJson(a)));
  //   } catch (err) {
  //     throw err;
  //   }
  // }

  static Future<List<PairBucket>> fetchPairBuckets(String pair) async {
    String url = apiUrl + '/pairs/' + pair + '/buckets';
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
      final volume = jsonmap['buckets'];
      if (volume == null) return null;
      return List<PairBucket>.from(volume.map((a) => PairBucket.fromJson(a)));
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
