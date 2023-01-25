import 'package:flutter/material.dart';

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({Key? key}) : super(key: key);

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextButton(
              onPressed: () {},
              child: const Text(
                  "Hi iam Text Button Don't click me i will not do any thing ")),
          ElevatedButton(
              onPressed: () {}, child: const Text("Hi Iam elevated button")),
          IconButton(onPressed: () {}, icon: const Icon(Icons.perm_phone_msg)),
          MaterialButton(
            onPressed: () {},
            color: Colors.blueAccent,
            child: const Text("Hi iam material"),
          ),
          BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CloseButton(
            onPressed: (){

            },
          )
        ],
      ),
    );
  }
}
