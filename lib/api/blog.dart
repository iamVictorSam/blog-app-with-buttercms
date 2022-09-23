import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductApi {
  static const String _apiKey = '08074ef496b7521de3aa69ae56875163ac0b1671';

  Future retrieve() async {
    const postsEndpoint = "v2/posts";
    try {
      final url =
          Uri.parse("https://api.buttercms.com/v2/posts?auth_token=$_apiKey");

      final response = await http.get(url);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);
      }
    } catch (e) {
      print(e);
    }
  }
}
