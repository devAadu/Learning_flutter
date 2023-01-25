import 'package:http/http.dart' as http;

import '../model/post.dart';

class RoutingWebservices{

  Future<List<Post>?> getData() async{
  var client = http.Client();
  var uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");

  var responce = await client.get(uri);

  if(responce.statusCode == 200){
    var json = responce.body;
    return postFromJson(json);
  }
  return null;

}

}