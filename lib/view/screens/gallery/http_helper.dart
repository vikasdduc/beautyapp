import 'dart:convert';
import 'package:glamcode/view/screens/gallery/share_helper.dart';
import 'package:http/http.dart' as http;

class HttpHelpers {
  static bool sessionTimeout = false;

  static getRefreshToken(String refresh) async {
    http.Response response;
    var access = "";
    var data = json.encode({"refresh": refresh});
    var urlUri = Uri.parse(""); //Refresh Token API
    var header = {"Content-Type": "application/json"};
    response = await http.post(urlUri, headers: header, body: data);

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      access = jsondata['access'];
    }
    return access;
  }

  static getRequestWithoutToken(String url) async {
    http.Response ?response;

    try {
      var urlUri = Uri.parse(url);
      // var header;
      // if (SharedHelper.accessToken != "") {
      //   header = {
      //     "Content-Type": "application/json",
      //     // "Authorization": "Bearer " + SharedHelper.accessToken
      //   };
      // } else {
      //   header = {"Content-Type": "application/json"};
      // }
      response = await http.get(urlUri, headers: {});
    } catch (ex) {
      var x = ex;
    }

    return response;
  }

  static getRequest(String url) async {
    http.Response ?response;

    try {
      var urlUri = Uri.parse(url);
      Map<String, String> header;
      if (SharedHelper.accessToken != "") {
        header = {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${SharedHelper.accessToken}"
        };
      } else {
        header = {"Content-Type": "application/json"};
      }
      response = await http.get(urlUri, headers: header);

      if (response.statusCode == 401 && SharedHelper.accessToken != "") {
        if (SharedHelper.refreshToken != "") {
          String token = await getRefreshToken(SharedHelper.refreshToken);

          SharedHelper.accessToken = token;
          if (SharedHelper.accessToken != "") {
            header = {
              "Content-Type": "multipart/form-data",
              "Authorization": "Bearer ${SharedHelper.accessToken}"
            };
          } else {
            header = {"Content-Type": "application/json"};
          }
          response = await http.get(urlUri, headers: {
            "Authorization": "Bearer $token",
          });
        }
      }
    } catch (ex) {
      var x = ex;
    }

    return response;
  }

  static postRequest(String url, var param) async {
    http.Response ?response;

    try {
      var urlUri = Uri.parse(url);
      var data = json.encode(param);
      // var header;
      // if (SharedHelper.accessToken != "") {
      //   header = {
      //     "Content-Type": "application/json",
      //     "Authorization": "Bearer " + SharedHelper.accessToken
      //   };
      // } else {
      //   header = {"Content-Type": "application/json"};
      // }
      response = await http.post(
        urlUri,
        body: data,
      );

      // if (response.statusCode == 401 && SharedHelper.accessToken != "") {
      //   if (SharedHelper.refreshToken != "") {
      //     String token = await getRefreshToken(SharedHelper.refreshToken);

      //     SharedHelper.accessToken = token;
      //     if (SharedHelper.accessToken != "") {
      //       header = {
      //         "Content-Type": "multipart/form-data",
      //         "Authorization": "Bearer " + SharedHelper.accessToken
      //       };
      //     } else {
      //       header = {"Content-Type": "application/json"};
      //     }
      //     response = await http.post(urlUri, body: data, headers: {
      //       "Authorization": "Bearer " + SharedHelper.accessToken,
      //     });
      //   }
      // }
    } catch (ex) {}

    return response;
  }
}
