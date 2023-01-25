import 'package:flutter/material.dart';

import '../model/post.dart';
import '../webservices/routing_webservices.dart';



class ApiCalling extends StatefulWidget {
  const ApiCalling({Key? key}) : super(key: key);

  @override
  State<ApiCalling> createState() => _ApiCallingState();
}

class _ApiCallingState extends State<ApiCalling> {
  List<Post>? myPost;
  bool isLoaded = false;

  @override
  initState() {
    super.initState();
    // getting data from the server
    
    getData();
  }
  
  void checkCoonection(){

  }

  void getData() async {
    myPost = (await RoutingWebservices().getData())!;
    if (myPost != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoaded,
      replacement: const Center(child: CircularProgressIndicator()),
      child: ListView.builder(
           padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10) ,
          itemCount: myPost?.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(myPost![index].title,style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),));
          }),
    );
  }

}
