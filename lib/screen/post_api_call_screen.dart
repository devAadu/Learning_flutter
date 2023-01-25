import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_flutter/const_file.dart';

import '../model/User.dart';
import 'package:http/http.dart' as http;

class PostApiCallScreen extends StatefulWidget {
  const PostApiCallScreen({Key? key}) : super(key: key);

  @override
  State<PostApiCallScreen> createState() => _PostApiCallScreenState();
}

class _PostApiCallScreenState extends State<PostApiCallScreen> {
  TextEditingController nameOfUser = TextEditingController();
  TextEditingController jobDescription = TextEditingController();

  User? gUserData;

  // creating future function because we have to wait to get the data from the server
  Future<User?> createUser(String userName, String jobName) async {
    String baeUrl = Constants().baseUrl + Constants().getUser;   // here it is base url

    final apiUrl = Uri.parse(baeUrl);  // hitting the entire url

    var client = http.Client();   /// creating the client from the http
    var body = <String,dynamic>{
      "name": userName,
      "job": jobName
    };
    var response =
        await client.post(apiUrl, body: body);  // calling the api and getting the response to the model class so that we can perform actions.

    if (response.statusCode == 201) {   // checking weather hitting the api is successful or not
      // successful
      final stringResponse = response.body;
      final json = jsonDecode(stringResponse);
      debugPrint("------------Json object getting----------"+json["name"]);
      debugPrint(stringResponse);   // printing the response
      return userFromJson(stringResponse);   // returning the response to the model class

    } else {
      return null;  // return null if any issue happen
    }
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          TextField(
            controller: nameOfUser,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Enter name"),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: jobDescription,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Enter Job"),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              if (nameOfUser.text.isNotEmpty &&
                  jobDescription.text.isNotEmpty) {
                final User lUserData =
                    (await createUser(nameOfUser.text, jobDescription.text))!;
                setState(() {
                  gUserData = lUserData;
                });
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlue),
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          gUserData == null
              ? Container()
              : Column(
                children: [
                  Text(gUserData!.name.toString().isNotEmpty
                      ? gUserData!.name.toString()
                      : ""),
                  Text(gUserData!.job.toString().isNotEmpty
                      ? gUserData!.job.toString()
                      : ""),
                  Text(gUserData!.id.toString().isNotEmpty
                      ? gUserData!.id.toString()
                      : ""),
                  Text(gUserData!.createdAt.toString().isNotEmpty
                      ? gUserData!.createdAt.toString()
                      : ""),
                ],
              ),

          customTextView(text:"Aadesh"),
          customTextView(text: "Mishra",color:Colors.red)
        ],
      ),
    );
  }

  Widget customTextView({required String text, MaterialColor? color}) {
    return Text(text,style: TextStyle(
      color: color ?? Colors.black
    ),);
  }

/*  Widget CustomTextView(required String text, {required String s,MaterialColor? color, required String text}) {
    return Text(text,style: TextStyle(
      color:
    ),);
  }*/
}
