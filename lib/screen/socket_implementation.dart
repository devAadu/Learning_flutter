
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';


class SocketImplementationScreen extends StatefulWidget {
   const SocketImplementationScreen({Key? key}) : super(key: key);

  @override
  State<SocketImplementationScreen> createState() => _SocketImplementationScreenState();
}

class _SocketImplementationScreenState extends State<SocketImplementationScreen> {

  final TextEditingController _controller = TextEditingController();
 /* final _channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );*/



  late Socket socket;

  List<Message> myList = [];

  @override
  initState(){

   super.initState();
   connectToServer();
/*   _channel.stream.listen((event) {
     print("--------------Message get from the socket" + event);

     setState((){
       myList.add(event);
     });

   });*/



  }


  void connectToServer() {
    try {

      // Configure socket transports must be sepecified
      socket = io('http://localhost:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      // Connect to websocket
      socket.connect();

      // Handle socket events
      socket.on('connection', (_) => print('connect: ${socket.id}'));
      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('message', (data) {

        // var jsonMessage = jsonDecode(data.toString());
        print("-------Message${data["message"]}");

        // {id: null, message: rtgrtgrtgrtg, username: username, sentAt: 2022-07-26 16:55}
        print("---------------Connection$data"); //

        setState((){

          myList.add(Message(data["id"].toString(), data["message"].toString(), data["username"].toString(), data["sendAt"].toString()));

        });

        // myList.add(jsonMessage["message"]);


      });


    } catch (e) {
      print(e.toString());
    }


  }

  @override
  dispose(){
    socket.close();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
            child: TextFormField(
             controller: _controller,decoration: const InputDecoration(
              label: Text("Enter Your message"),
            ),
            ),
          ),
          const SizedBox(height: 10.0,),
          GestureDetector(
            onTap: (){
              var jsonString = {
                "name": "Its Me ",
                "job": "Me me "
              };

              if(_controller.text.isNotEmpty){
                sendMessage(_controller.text);

              }

             /* if(_controller.text.isNotEmpty){
                _channel.sink.add(jsonString.toString());
                _controller.clear();
              }*/
            },
            child: const Text("Send Message",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),),
          ),
          const SizedBox(height: 10.0,),
          Expanded(
              child:
               ListView.builder(
                   itemCount: myList.length,
                   itemBuilder: (context,index){
                 return Align(
                   alignment: myList[index].id == socket.id ? Alignment.centerRight:Alignment.centerLeft ,
                   child: Text(myList[index].message,style: const TextStyle(
                     color: Colors.green,
                     fontSize: 16,
                     fontWeight: FontWeight.w500
                   ),),
                 );
               })
          )


        ],

      ),
    );
  }

  sendMessage(String message) {
    socket.emit("message",
      {
        "id": socket.id,
        "message": message, //--> message to be sent
        "username": "username",
        "sentAt": DateTime.now().toLocal().toString().substring(0, 16),
      },
    );
  }


}

class Message{

  final String id;
  final String message;
  final String username;
  final String date;

  Message(this.id, this.message, this.username, this.date);
}
