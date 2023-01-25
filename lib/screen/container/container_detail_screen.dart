import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class ContainerDetailScreen extends StatefulWidget {
  const ContainerDetailScreen({Key? key}) : super(key: key);

  @override
  State<ContainerDetailScreen> createState() => _ContainerDetailScreenState();
}

class _ContainerDetailScreenState extends State<ContainerDetailScreen> {
  int currentIndex = 0;
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      /*  bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.phone_iphone_rounded),label: "Output"),
        BottomNavigationBarItem(icon: Icon(Icons.code),label: "Code")
      ],
        currentIndex: currentIndex,
        onTap: _onItemTapped,

      ),*/
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Container(
            color: Colors.green,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: const Text(
              "Iam A container a simple with background color and vertical 20 padding ",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.blue),
            child: const Text(
              "Hi Iam With Conners radius 15",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              "hi iam containner with the border",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          DottedBorder(
            dashPattern: const [8, 4],
            strokeWidth: 2,
            color: Colors.blueAccent,
            strokeCap: StrokeCap.round,
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            padding: const EdgeInsets.all(6),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: const Text(
                " hi iam A container with dash border ",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueAccent, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              // Use setState to rebuild the widget with new values.
              setState(() {
                // Create a random number generator.
                final random = Random();

                // Generate a random width and height.
                _width = random.nextInt(300).toDouble();
                _height = random.nextInt(300).toDouble();

                // Generate a random color.
                _color = Color.fromRGBO(
                  random.nextInt(256),
                  random.nextInt(256),
                  random.nextInt(256),
                  1,
                );

                // Generate a random border radius.
                _borderRadius =
                    BorderRadius.circular(random.nextInt(100).toDouble());
              });
            },
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: _borderRadius,
              ),
              curve: Curves.fastOutSlowIn,
              child: const Center(
                  child: Text(
                "Click Me",
                style: TextStyle(color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}
