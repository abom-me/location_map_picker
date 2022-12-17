import 'dart:convert';
import 'package:http/http.dart' as http;
class RequestHelper{
  static Future getRequest(String url) async{
    var url2 = Uri.parse(url);
    http.Response response=await http.get(url2);
    try{
      if(response.statusCode==200){
        String data=response.body;
        var decodeData=jsonDecode(data);
        return decodeData;
      }
      else{
        return'failed';
      }
    }catch(e){
      return 'failed';
    }

  }
}