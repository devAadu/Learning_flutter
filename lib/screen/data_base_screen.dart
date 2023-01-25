import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../const_file.dart';
import '../model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DataBaseScreen extends StatefulWidget {
  const DataBaseScreen({Key? key}) : super(key: key);

  @override
  State<DataBaseScreen> createState() => _DataBaseScreenState();
}

class _DataBaseScreenState extends State<DataBaseScreen> {
  UserModel? userData;
  int currentPage = 1;
  bool isLoading = true;

  List<Datum> listOfUsersDetail = [];
  Future<UserModel?> getUserData(int pageNo) async {

    try{
      final client = http.Client();
      // String baeUrl = "https://reqres.in/api/users";   // here it is base url

      String baseUrl = Constants().baseUrl + Constants().getUser ;
      final response = await client.get(Uri.parse("$baseUrl""?page=$pageNo")) ;

      if(response.statusCode == 200){
        final json = jsonDecode(response.body);
        await putData(response.body);
        var myData = box!.toMap();
        print("---------->Get Data From Data Base${myData[0]}");
        print("---------->Getting data from the object query$json");
        return userModelFromJson(myData[0].toString());
      }else{
        return null;
      }
    }catch(SocketExpetion){
      _getDataFromDataBase();
    }
    return null;


  }

  Future putData(data) async {
    await box!.clear();

    ///Insert data here
    // box!.put(0, data);
    box!.add(data);

   }

  Future<void> addDataToModel() async {
    final  lUserData = await getUserData(currentPage);
    setState((){
      userData = lUserData;
      listOfUsersDetail.addAll(userData!.data);
      isLoading = false;
    });

  }

  Box? box;
  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox("userData");
    return;
  }
  late bool isOnLine;
  late StreamSubscription subscription;

  ///Check For Internet Connection
  _connectivityCheckerService() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      // Got a new connectivity status!
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {

        setState(() {
          isOnLine = true;
        });
      } else {

        setState(() {
          isOnLine = false;
        });
      }
    });
  }

  ///If No Internet access  then will retrieve data and show to ui
  _getDataFromDataBase() async {
    var myData = box!.toMap();
    setState((){
      userData = userModelFromJson(myData[0].toString());
      listOfUsersDetail.addAll(userData!.data);
      isLoading = false;
    });
  }
  @override
  void initState() {
    openBoxInitState();
    super.initState();
  }

  openBoxInitState() async {
    await openBox();
    addDataToModel();


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
            // addDataToModel();

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
                      child:  CachedNetworkImage(
                        imageUrl: listOfUsersDetail[index].avatar,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),),
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
