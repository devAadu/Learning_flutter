import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SnackBarScreen extends StatefulWidget {
  const SnackBarScreen({Key? key}) : super(key: key);

  @override
  State<SnackBarScreen> createState() => _SnackBarScreenState();
}

class _SnackBarScreenState extends State<SnackBarScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              const snackBar = SnackBar(content: Text("Hi iam Snack"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text("Click Me"),
          ),
          ElevatedButton(
            onPressed: () {
              const snackBar = SnackBar(
                content: Text("Hi iam colored Snack"),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.blueAccent,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text("Touch Me"),
          ),
          //Using a library/pod for making the snack bar to top
          TapBounceContainer(
            onTap: () {
              showTopSnackBar(
                context,
                const CustomSnackBar.success(
                  message:
                      "Hi iam colored Snack",
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Please touch me ",
                style: TextStyle(color: Colors.blueAccent, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
