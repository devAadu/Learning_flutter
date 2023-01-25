import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pusher_client/pusher_client.dart';

class PusherClientScreen extends StatefulWidget {
  const PusherClientScreen({Key? key}) : super(key: key);

  @override
  State<PusherClientScreen> createState() => _PusherClientScreenState();
}

class _PusherClientScreenState extends State<PusherClientScreen> {

  late PusherClient pusher;
  late Channel channel;
  String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOTIuMTY4LjEuMTYzXC9nb3Zpc2libGVfYmFja2VuZFwvYXBpXC92ZXJpZnktb3RwIiwiaWF0IjoxNjU5NTA0NzczLCJleHAiOjE2NTk1MjYzNzMsIm5iZiI6MTY1OTUwNDc3MywianRpIjoiQ2VnQzc5ajdhU2tKV0tXdCIsInN1YiI6MTUsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.mzeg9F0vo16pfiYB-H5tnxacDden4iIUJYCYWZLzIwY";
  final _channelName = "private-chatify";
  final _apiKey = "24e8d3fed51cc0fc41ec";
  final _cluster = "ap2";
  final _eventName = "messaging";
  @override
  initState(){

    super.initState();

    pusher = PusherClient(
      _apiKey,
      PusherOptions(
        // if local on android use 10.0.2.2
        host: '10.0.2.2',
        cluster: _cluster,
        encrypted: false,
        auth: PusherAuth(
          'http://192.168.1.163/govisible_backend/chatify/api/chat/auth',
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      ),
      enableLogging: true,
    );

    channel = pusher.subscribe(_channelName);

    pusher.onConnectionStateChange((state) {
      log("previousState: ${state!.previousState}, currentState: ${state.currentState}");
    });

    pusher.onConnectionError((error) {
      log("error: ${error!.message}");
    });

    channel.bind(_eventName, (event) {
      log(event!.data!);
    });
/*
    channel.bind('order-filled', (event) {
      log("Order Filled Event" + event!.data.toString());
    });*/




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            child: const Text('Unsubscribe Private Orders'),
            onPressed: () {

              pusher.unsubscribe(_channelName);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            child: const Text('Unbind Status Update'),
            onPressed: () {
              channel.unbind('status-update');
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            child: const Text('Unbind Order Filled'),
            onPressed: () {
              channel.unbind('order-filled');
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            child: const Text('Bind Status Update'),
            onPressed: () {
              channel.bind('status-update', (PusherEvent? event) {
                log("Status Update Event${event!.data}");
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            child: const Text('Trigger Client Typing'),
            onPressed: () {
              channel.trigger(_eventName, {'name': 'Bob'});
            },
          ),
        ],
      ),
    );
  }
}
