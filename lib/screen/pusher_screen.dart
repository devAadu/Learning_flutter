import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherScreen extends StatefulWidget {
  const PusherScreen({Key? key}) : super(key: key);

  @override
  State<PusherScreen> createState() => _PusherScreenState();
}

class _PusherScreenState extends State<PusherScreen> {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  final _apiKey = "24e8d3fed51cc0fc41ec";
  final _cluster = "ap2";
  final _channelName = "private-chatify";
  final _eventName = "messaging";
  String _log = 'output:\n';
  String Connections = "Connect";

  String token = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOTIuMTY4LjEuMTYzXC9nb3Zpc2libGVfYmFja2VuZFwvYXBpXC92ZXJpZnktb3RwIiwiaWF0IjoxNjU5NTA0NzczLCJleHAiOjE2NTk1MjYzNzMsIm5iZiI6MTY1OTUwNDc3MywianRpIjoiQ2VnQzc5ajdhU2tKV0tXdCIsInN1YiI6MTUsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.mzeg9F0vo16pfiYB-H5tnxacDden4iIUJYCYWZLzIwY";

  final TextEditingController _controller = TextEditingController();

  String auth = "";
  String channelData = "";


  void log(String text) {
    print("LOG: $text");
    setState(() {
      _log += "$text\n";
    });
  }

/* createAuth() async {
    String baeUrl = "http://192.168.1.163/example-app/chatify/api/chat/auth";   // here it is base url

    final apiUrl = Uri.parse(baeUrl);  // hitting the entire url

    var client = http.Client();   /// creating the client from the http
    var body = <String,dynamic>{
      "socket_id": pusher.getSocketId(),
      "channel_name": "private-chatify",
      "user_id":4,
      "name":"test"
    };


    var response = await client.post(apiUrl, body: body);  // calling the api and getting the response to the model class so that we can perform actions.
    final stringResponse = response.body;
    if (response.statusCode == 200) {   // checking weather hitting the api is successful or not
      // successful

      final json = jsonDecode(stringResponse);
      debugPrint(stringResponse);   // printing the

    } else {
      return null;  // return null if any issue happen
    }
  }*/

   Future<void> pusherDiconnect() async {
    await pusher.unsubscribe(channelName: _channelName);
    await pusher.disconnect();

    print("pusherDiconnect");
  }

   Future<void> pusherReConnect() async {
    await pusher.subscribe(channelName: _channelName);
    await pusher.connect();

    print("pusherReConnect");
  }


  void _connectPusher() async {


    try{
      await pusher.init(
        apiKey: _apiKey,
        cluster: _cluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
         // onAuthorizer: onAuthorizer,
           authParams:{
             'headers': { 'Authorization': token }
           },
        authEndpoint: "http://192.168.1.163/govisible_backend/chatify/api/chat/auth"
      );

      // createAuth();
    }catch (e){
      log("--------->ERROR: $e");
    }


  }

  dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
    return {
       "auth": "24e8d3fed51cc0fc41ec:c9700294f12463ec82621bc95836752a3ebd1d5ab3b0e30c27a21def60faf2c0",
       "channel_data": '{"user_id":4,"user_info":{"name":"tets"}}',
       "shared_secret": "c9f6c2d10820c040fce3"

    };
  }


  void onDecryptionFailure(String event, String reason) {
    log("--------->onDecryptionFailure: $event reason: $reason");
  }

  void onEvent(PusherEvent event) {
    log("--------->onEvent: $event");
  }


  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("--------->onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("Me: $me");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("--------->onSubscriptionError: $message Exception: $e");
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("--------->Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    log("--------->onError: $message code: $code exception: $e");
  }


  @override
  initState(){


    super.initState();

    _connectPusher();


  }

  void _disposePusher() async{
    await pusher.unsubscribe(channelName: _channelName);
    await pusher.disconnect();
  }

  @override
  dispose() {
    _disposePusher();
    super.dispose();

  }


  // private-chatify  => channel
  // messaging => event

  String message = {"from_id":"4","to_id":"1","message":"message-card data-id=1909488436"}.toString();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ///edit text
          Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
            child: TextFormField(
              controller: _controller,decoration: const InputDecoration(
              label: Text("Enter Your message"),
            ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
              onTap: (){
                _sendMessageUsingPusher();
              },
              child: const Text("Send Message")),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
              onTap: (){
                if(Connections=="connect"){
                  pusherDiconnect();
                  setState((){
                    Connections = "Connect";
                  });

                }else{
                  setState((){
                    Connections = "disConnect";
                  });
                  pusherReConnect();
                }

              },
              child: Text(Connections)),
        ],
      ),
    );
  }


  void _sendMessageUsingPusher() {
    pusher.trigger(PusherEvent(
        channelName: _channelName,
        eventName: _eventName,
        data: message));
  }

  // json
  // {"from_id":1,"to_id":"4","message":"<div class=\"message-card\" data-id=\"1909488436\">\n        <p>hjgf\n            <sub title=\"2022-08-02 05:34:52\">1 second ago</sub>\n            \n                    </p>\n        \n            </div>\n    \n\n"}
}
