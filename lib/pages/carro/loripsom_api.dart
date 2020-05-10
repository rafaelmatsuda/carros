import 'package:http/http.dart' as http;
import 'dart:async';

class LoripsonBloc {
  static String lorim;
  final _streamController = StreamController<String>();

  Stream<String> get stream => _streamController.stream;

  fetch() async {
    try {
      String s = lorim ?? await LoripsonApi.getLoripson();
      lorim = s;
      _streamController.add(s);
    } catch (e) {
      print(e);
      _streamController.addError(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}

class LoripsonApi {
  static Future<String> getLoripson() async {
    var url = "https://loripsum.net/api";

    print("GET >> $url");

    var response = await http.get(url);

    String text = response.body;

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return text;
  }
}
