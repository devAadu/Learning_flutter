import 'package:flutter/material.dart';

class SilverAppBar extends StatefulWidget {
  const SilverAppBar({Key? key}) : super(key: key);

  @override
  State<SilverAppBar> createState() => _SilverAppBarState();
}

class _SilverAppBarState extends State<SilverAppBar> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        //App bar to create collapsing toolbar  similar like android
        const SliverAppBar(
          pinned: true,
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('SliverAppBar'),
            background: FlutterLogo(),
          ),
        ),
        //Creating a box to contain Text using Sliver Box
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
            child: Center(
              child: Text('Scroll to see the SliverAppBar in effect.'),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                color: index.isOdd ? Colors.white : Colors.black12,
                height: 100.0,
                child: Center(
                  child: Text('$index', textScaleFactor: 5),
                ),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    );
  }
}
