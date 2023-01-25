import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';

class RivAnimationScreen extends StatefulWidget {
  const RivAnimationScreen({Key? key}) : super(key: key);

  @override
  State<RivAnimationScreen> createState() => _RivAnimationScreenState();
}

class _RivAnimationScreenState extends State<RivAnimationScreen> {
  late String animationURL;
  Artboard? _teddyArtboard;
  SMITrigger? successTrigger, failTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? numLook;
  bool isVisible = true;
  late FocusNode myFocusNode;

  StateMachineController? stateMachineController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationURL = defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS
        ? 'assets/img/login.riv'
        : 'img/login.riv';
    rootBundle.load(animationURL).then(
          (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        stateMachineController =
            StateMachineController.fromArtboard(artboard, "Login Machine");
        if (stateMachineController != null) {
          artboard.addController(stateMachineController!);

          stateMachineController!.inputs.forEach((e) {
            debugPrint(e.runtimeType.toString());
            debugPrint("name${e.name}End");
          });

          stateMachineController!.inputs.forEach((element) {
            if (element.name == "trigSuccess") {
              successTrigger = element as SMITrigger;
            } else if (element.name == "trigFail") {
              failTrigger = element as SMITrigger;
            } else if (element.name == "isHandsUp") {
              isHandsUp = element as SMIBool;
            } else if (element.name == "isChecking") {
              isChecking = element as SMIBool;
            } else if (element.name == "numLook") {
              numLook = element as SMINumber;
            }
          });
        }

        setState(() => _teddyArtboard = artboard);
      },
    );
    myFocusNode = FocusNode();
  }

  void handsOnTheEyes() {
    isHandsUp?.change(isVisible);
  }

  void lookOnTheTextField() {
    isHandsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);
  }

  void moveEyeBalls(val) {
    numLook?.change(val.length.toDouble());
  }

  void login() {
    isChecking?.change(false);
    isHandsUp?.change(false);
    if (_emailController.text == "admin" &&
        _passwordController.text == "admin") {
      successTrigger?.fire();
    } else {
      failTrigger?.fire();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffd6e2ea),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_teddyArtboard != null)
                SizedBox(
                  width: 250,
                  height: 250,
                  child: Rive(
                    artboard: _teddyArtboard!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              Container(
                alignment: Alignment.center,
                width: 400,
                padding: const EdgeInsets.only(bottom: 15),
                margin: const EdgeInsets.only(bottom: 15 * 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const SizedBox(height: 15 * 2),
                          TextField(
                            controller: _emailController,
                            onTap: lookOnTheTextField,
                            onChanged: moveEyeBalls,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(fontSize: 14),
                            cursorColor: const Color(0xffb04863),
                            decoration: const InputDecoration(
                              hintText: "Email/Username",
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                              focusColor: Color(0xffb04863),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffb04863),
                                ),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            focusNode: myFocusNode,
                            controller: _passwordController,
                            onTap: handsOnTheEyes,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isVisible,
                            style: const TextStyle(fontSize: 14),
                            cursorColor: const Color(0xffb04863),
                            decoration:  InputDecoration(
                              hintText: "Password",
                              filled: true,
                              suffix: GestureDetector(
                                onTap: () {
                                  setState((){
                                    if(!myFocusNode.hasFocus){
                                      myFocusNode.requestFocus();
                                    }

                                    isVisible = !isVisible;
                                    isHandsUp?.change(isVisible);

                                  });

                                },
                                child: isVisible
                                    ? Image.asset("assets/img/ic_eyes.png",
                                    width: 20, height: 20, color: Colors.black)
                                    : Image.asset("assets/img/ic_eyes_closed.png",
                                    width: 20, height: 20, color: Colors.black),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                              focusColor: Color(0xffb04863),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffb04863),
                                ),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //remember me checkbox
                              Row(
                                children: [
                                  Checkbox(
                                    value: false,
                                    onChanged: (value) {},
                                  ),
                                  const Text("Remember me"),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: login,
                                style: ElevatedButton.styleFrom(
                                ),
                                child: const Text("Login"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



