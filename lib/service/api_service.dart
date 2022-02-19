import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiServices {
  var serviceResponse;

  Future executeGet(serviceName) async {
    await http.get(Uri.parse(serviceName)).then((value) => {
          if (value.statusCode == 200)
            {
              serviceResponse = json.decode(value.body),
            }
          else
            {
              serviceResponse = json.decode(value.body),
            }
        });
    return serviceResponse;
  }
}
