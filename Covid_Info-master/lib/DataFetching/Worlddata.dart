import 'package:http/http.dart' as http;
class worlddata{
  Future<http.Response> world() async{
    return await http.get("https://coronavirus-19-api.herokuapp.com/all");
  }
}