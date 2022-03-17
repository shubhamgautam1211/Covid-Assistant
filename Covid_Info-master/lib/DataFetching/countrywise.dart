import 'package:http/http.dart' as http;
class countrywise{
  Future<http.Response> countries() async{
    return await http.get("https://corona.lmao.ninja/v2/countries?yesterday&sort");
  }
}