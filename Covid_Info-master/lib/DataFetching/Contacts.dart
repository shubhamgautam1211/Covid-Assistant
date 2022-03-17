import 'package:http/http.dart' as http;
class contactsno{
  Future<http.Response> contactno() async{
    return await http.get("https://api.rootnet.in/covid19-in/contacts");
  }
}