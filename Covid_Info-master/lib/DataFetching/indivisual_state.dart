import 'package:http/http.dart' as http;
class statedata{
  Future<http.Response> statedata1() async{
    return await http.get("https://api.rootnet.in/covid19-in/stats/latest");
  }
}