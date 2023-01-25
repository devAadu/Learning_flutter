import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_flutter/const_file.dart';

import '../model/user_model.dart';
import 'package:http/http.dart' as http;

class GetQueryApiScreen extends StatefulWidget {
  const GetQueryApiScreen({Key? key}) : super(key: key);

  @override
  State<GetQueryApiScreen> createState() => _GetQueryApiScreenState();
}



class _GetQueryApiScreenState extends State<GetQueryApiScreen> {

  UserModel? userData;
  int currentPage = 1;
  bool isLoading = true;

  List<Datum> listOfUsersDetail = [];

  Future<UserModel?> getUserData(int pageNo) async {

    final client = http.Client();
    // String baeUrl = "https://reqres.in/api/users";   // here it is base url

     String baseUrl = Constants().baseUrl + Constants().getUser ;
    final response = await client.get(Uri.parse("$baseUrl""?page=$pageNo")) ;

    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      print("---------->Getting data from the object query$json");
      return userModelFromJson(response.body);
    }else{
      return null;
    }

  }

  @override
  initState() {
    super.initState();

    addDataToModel();
  }

  Future<void> addDataToModel() async {
    final  lUserData = await getUserData(currentPage);
    setState((){
      userData = lUserData;
      listOfUsersDetail.addAll(userData!.data);
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo){

          // for pagination getting more data from the server and append to the list  to do that we have used notification listener on the scroll
          debugPrint("${(scrollInfo.metrics.maxScrollExtent - scrollInfo.metrics.pixels).round()}");
          if(!isLoading && (scrollInfo.metrics.maxScrollExtent - scrollInfo.metrics.pixels).round() <=200 ){
            // will fetch new data
            currentPage++;
            addDataToModel();

            setState((){
              isLoading = true;

            });


          }

          return true;


        },
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listOfUsersDetail.length,
          itemBuilder: (context,index){
          return Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(listOfUsersDetail[index].avatar,width: 50,height: 50,)),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${listOfUsersDetail[index].firstName} ${listOfUsersDetail[index].lastName}" ),
                    const SizedBox(height: 10,),
                    Text(listOfUsersDetail[index].email),
                  ],
                )

              ],
            ),
          );
        },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          currentPage++;
          addDataToModel();
          isLoading = true;
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ),
    );
  }
}
