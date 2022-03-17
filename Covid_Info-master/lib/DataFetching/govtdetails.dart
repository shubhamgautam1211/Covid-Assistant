import 'package:http/http.dart' as http;
class govt{
  Future<http.Response> govt1() async{
    return await http.get("https://api.rootnet.in/covid19-in/notifications");
  }
}