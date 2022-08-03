import 'package:http/http.dart' as http;

class NetworkHelper {
  Future<http.Response> get(String urlApi) async {
    var url = Uri.parse(urlApi);
    var response = await http.get(url);
    return response;
  }
}
