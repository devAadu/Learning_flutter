import 'package:flutter/material.dart';

import 'package:widget_with_codeview/widget_with_codeview.dart';

class DetailScreen extends StatefulWidget {
    const DetailScreen( this.title, this.sourceFile  , this.className, {Key? key}) : super(key: key);

   final String title;
   final String sourceFile;
   final dynamic className;


  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading:  GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
            child: const Icon(Icons.arrow_back,)),
        title:  Text(widget.title),
        actions: const [
          Icon(Icons.add_alert),
          SizedBox(width: 10,)
        ],
        bottomOpacity: 1,
        shadowColor: Colors.blue,

      ),
      body: _body(),
    );
  }
  Widget _body(){
    return  WidgetWithCodeView(sourceFilePath: widget.sourceFile,
      child: widget.className,
    );
  }
}
