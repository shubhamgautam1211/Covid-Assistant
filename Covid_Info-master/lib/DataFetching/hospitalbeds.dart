import 'package:http/http.dart' as http;
class beds{
  Future<http.Response> beds1() async{
    return await http.get("https://api.rootnet.in/covid19-in/hospitals/beds");
  }
}