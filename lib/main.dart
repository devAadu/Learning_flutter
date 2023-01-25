
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/screen/calender_screen.dart';
import 'package:learning_flutter/screen/google_login.dart';
import 'package:learning_flutter/screen/map_screen.dart';
import 'package:learning_flutter/screen/paypal_intregation.dart';
import 'package:learning_flutter/screen/rive_animation.dart';
import 'package:learning_flutter/screen/stripe_payment_example.dart';
import 'package:learning_flutter/screen/time_slot.dart';
import 'package:learning_flutter/screen/tinder_like_screen.dart';
import 'package:learning_flutter/utils/page_routes.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screen/import_screens.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // initializing the firebase app
  await Firebase.initializeApp();
  Stripe.publishableKey = "pk_test_51M1RJNSANMbsTvQMZI6ucdAR2vHlIi0fRYlPNHe56wDz6oQZe1GQwEpfBstCKQz5D888Smt4ku8qjjl4rWCnhlQl00yKC1RtR8";
  runApp(  const MyApp(),);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "Hello",),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<MyColors> myColors = [
  MyColors("Yellow", Colors.yellow),
  MyColors("Red", Colors.red),
  MyColors("BlueAccent", Colors.blue)
];

   MaterialColor themeColor = Colors.blue;

class _MyHomePageState extends State<MyHomePage> {
  List<MyData> myDataList = [
    MyData("Container", "lib/screen/container/container_detail_screen.dart", const ContainerDetailScreen()),
    MyData("Text", "lib/screen/text_screen.dart", const TextScreen()),
    MyData("Button", "lib/screen/buttons_screen.dart", const ButtonScreen()),
    MyData("SnackBar", "lib/screen/snackbar_screen.dart", const SnackBarScreen()),
    MyData("Alert", "lib/screen/alert_screen.dart", const AlertScreen()),
    MyData("SilverAppBar And SilverList", "lib/screen/silver_appbar.dart", const SilverAppBar()),
    MyData("Animation Icons", "lib/screen/animation_icons.dart", const AnimationIcons()),
    MyData("GetApi call", "lib/screen/api_calling.dart", const ApiCalling()),
    MyData("PostApi call", "lib/screen/post_api_call_screen.dart", const PostApiCallScreen()),
    MyData("GetApiQuery call", "lib/screen/get_query_api.dart", const GetQueryApiScreen()),
    MyData("Chart", "lib/screen/chart_screen.dart", const ChartScreen()),
    MyData("Socket_implementation", "lib/screen/socket_implementation.dart", const SocketImplementationScreen()),
    MyData("RazorPay_implementation", "lib/screen/razorpay_screen.dart", const RazorpayScreen()),
    MyData("Pusher_implementation", "lib/screen/pusher_screen.dart", const PusherScreen()),
    MyData("Pusher_Client", "lib/screen/pusher_client.dart", const PusherClientScreen()),
    MyData("Local Notification", "lib/screen/local_notification.dart", const LocalNotification()),
    MyData("FaceBook Login", "lib/screen/facebook_login.dart", const FaceBookLogin()),
    MyData("DownloadFile&Show", "lib/screen/download_files.dart", const DownLoadFiles()),
    MyData("DataBaseWithRestApi", "lib/screen/data_base_screen.dart", const DataBaseScreen()),
    MyData("PayPal", "lib/screen/paypal_intregation.dart", const PaypalIntegration()),
    MyData("Google Sign in", "lib/screen/google_login.dart", const GoogleLogin()),
    MyData("Clander", "lib/screen/calender_screen.dart", const ClanderScreen()),
    MyData("timeSloat", "lib/screen/time_slot.dart", const TimeSlotScreen()),
    MyData("Stripe Payment", "lib/screen/stripe_payment_example.dart", const StripePaymentExample()),
    MyData("Tinder Swipe", "lib/screen/tinder_like_screen.dart", const TinderScreen()),
    MyData("Map View", "lib/screen/map_screen.dart", const MapScreen()),
    MyData("Rive Animation", "lib/screen/rive_animation.dart", const RivAnimationScreen()),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          GestureDetector(
            child: const Icon(Icons.change_circle),
            onTap: () {
              _showBottomSheet(context);
            },
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: MediaQuery.of(context).size.height,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: myDataList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailScreen(
                            myDataList[index].title,
                            myDataList[index].sourceFile,
                            myDataList[index].className)));
              },
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    myDataList[index].title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )),
                  // const Icon(Icons.heart_broken_outlined,size: 25,),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 25,
                  )
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
      ),
    );
  }
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: GridView.builder(
              itemCount: myColors.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    if (kDebugMode) {
                      print(myColors[index].color);
                    }
                    setState((){
                      themeColor = myColors[index].color;
                    });
                    Navigator.pop(context);
                    // Restart.restartApp();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: myColors[index].color,
                        borderRadius: BorderRadius.circular(10)

                    ),

                  ),
                );
              },
            ),
          );
        });
  }

}


