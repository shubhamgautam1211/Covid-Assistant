import 'package:http/http.dart' as http;
class statedata{
  Future<http.Response> states() async{
    return await http.get("https://gist.githubusercontent.com/shubhamjain/35ed77154f577295707a/raw/7bc2a915cff003fb1f8ff49c6890576eee4f2f10/IndianStates.json");
  }
}