import 'package:flutter/material.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({Key? key}) : super(key: key);

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Column(
        children:  [

          const Text("Hi iam Normal Text"),
          const SizedBox(height: 10,),
          const Text("Hi iam bold Text with colors",style: TextStyle(color: Colors.blueAccent,fontSize: 25,fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          const Text("Hi iam overflow text widgets property creating for the me and you to help out ",overflow: TextOverflow.ellipsis,),
          const SizedBox(height: 10,),
          const Text.rich(TextSpan(text: "hi",children: [
            TextSpan(text: ' iam italic ', style: TextStyle(fontStyle: FontStyle.italic)),
            TextSpan(text: 'and iam bold', style: TextStyle(fontWeight: FontWeight.bold)),
          ])),
          const SizedBox(height: 10,),
        /*  Text(
            'Greetings, planet!',
            style: TextStyle(
                fontSize: 40,
                foreground: Paint()
                  ..shader = Gradient.linear(
                    const Offset(0, 20),
                    const Offset(150, 20),
                    <Color>[
                      Colors.red,
                      Colors.yellow,
                    ],
                  )
            ),
          )*/
          GradientText(
            "Hi iam gradient text custom widgets",
            gradient: LinearGradient(
              colors: [
                Colors.red.shade400,
                Colors.yellow.shade900,
              ]
            ),
            style: const TextStyle(fontSize: 16),

          ),
          const SizedBox(height: 10,),
          const Text("hi iam shadow of the text",style: TextStyle(
            shadows: [
              Shadow(
                offset: Offset(10.0, 10.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              Shadow(
                offset: Offset(10.0, 10.0),
                blurRadius: 8.0,
                color: Color.fromARGB(125, 0, 0, 255),
              ),
            ]
          ),),

        ],
      ),
    );
  }


}

class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
