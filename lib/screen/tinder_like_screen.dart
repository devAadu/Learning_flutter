import 'package:flutter/material.dart';


class TinderScreen extends StatefulWidget {
  const TinderScreen({Key? key}) : super(key: key);

  @override
  State<TinderScreen> createState() => _TinderScreenState();
}

class _TinderScreenState extends State<TinderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: const [

          CardsStackWidget(),
        ],
      ),
    );
  }
}

class Profile {
  const Profile({
    required this.name,
    required this.distance,
    required this.imageAsset,
  });
  final String name;
  final String distance;
  final String imageAsset;
}


class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.profile}) : super(key: key);
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/1.5,
      width: 340,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                profile.imageAsset,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 80,
              width: 340,
              decoration: ShapeDecoration(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      profile.name,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        fontSize: 21,
                      ),
                    ),
                    Text(
                      profile.distance,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DragWidget extends StatefulWidget {
  const DragWidget({
    Key? key,
    required this.profile,
    required this.index,
    required this.swipeNotifier,
    this.isLastCard = false,
  }) : super(key: key);
  final Profile profile;
  final int index;
  final ValueNotifier<Swipe> swipeNotifier;
  final bool isLastCard;

  @override
  State<DragWidget> createState() => _DragWidgetState();
}

enum Swipe { left, right, none,top }

class _DragWidgetState extends State<DragWidget> {
  ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Draggable<int>(
        // Data is the value this Draggable stores.
        data: widget.index,
        feedback: Material(
          color: Colors.transparent,
          child: ValueListenableBuilder(
            valueListenable: swipeNotifier,
            builder: (context, swipe, _) {
              return RotationTransition(
                turns: swipe != Swipe.none
                    ? swipe == Swipe.left
                    ? const AlwaysStoppedAnimation(-15 / 360)
                    : const AlwaysStoppedAnimation(15 / 360)
                    : const AlwaysStoppedAnimation(0),
                child: Stack(
                  children: [
                    ProfileCard(profile: widget.profile),
                    swipe != Swipe.none
                        ? swipe == Swipe.right
                        ? Positioned(
                      top: 40,
                      left: 20,
                      child: Transform.rotate(
                        angle: 12,
                        child: TagWidget(
                          text: 'LIKE',
                          color: Colors.green[400]!,
                        ),
                      ),
                    )
                        : Positioned(
                      top: 50,
                      right: 24,
                      child: Transform.rotate(
                        angle: -12,
                        child: TagWidget(
                          text: 'DISLIKE',
                          color: Colors.red[400]!,
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
          ),
        ),
        onDragUpdate: (DragUpdateDetails dragUpdateDetails) {
          // When Draggable widget is dragged right
          if (dragUpdateDetails.delta.dx > 0 && dragUpdateDetails.globalPosition.dx >
                  MediaQuery.of(context).size.width / 2) {
            swipeNotifier.value = Swipe.right;
          }
          // When Draggable widget is dragged left
          if (dragUpdateDetails.delta.dx < 0 && dragUpdateDetails.globalPosition.dx <
                  MediaQuery.of(context).size.width / 2) {
            swipeNotifier.value = Swipe.left;
          }
          if (dragUpdateDetails.delta.dy < 0 && dragUpdateDetails.globalPosition.dy <
              MediaQuery.of(context).size.height / 2) {
            swipeNotifier.value = Swipe.top;
          }
        },
        onDragEnd: (drag) {
          swipeNotifier.value = Swipe.none;
        },

        childWhenDragging: Container(
          color: Colors.transparent,
        ),

        child: ProfileCard(profile: widget.profile),
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  const TagWidget({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: color,
            width: 4,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 36,
        ),
      ),
    );
  }
}


class CardsStackWidget extends StatefulWidget {
  const CardsStackWidget({Key? key}) : super(key: key);

  @override
  State<CardsStackWidget> createState() => _CardsStackWidgetState();
}

class _CardsStackWidgetState extends State<CardsStackWidget>
    with SingleTickerProviderStateMixin {
  List<Profile> draggableItems = [
    const Profile(
        name: 'Yen Ji',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_yen.jpg'),
    const Profile(
        name: 'Suzy',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_suzy.jpg'),
    const Profile(
        name: 'Seo Yen',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_seo_yen.jpg'),
    const Profile(
        name: 'Jisoo',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_jisoo.jpg'),
    const Profile(
        name: 'Ye ji',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_yeji.jpg'),

    const Profile(
        name: 'Yen Ji',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_yen.jpg'),
    const Profile(
        name: 'Suzy',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_suzy.jpg'),
    const Profile(
        name: 'Seo Yen',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_seo_yen.jpg'),
    const Profile(
        name: 'Jisoo',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_jisoo.jpg'),
    const Profile(
        name: 'Ye ji',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_yeji.jpg'),

    const Profile(
        name: 'Yen Ji',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_yen.jpg'),
    const Profile(
        name: 'Suzy',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_suzy.jpg'),
    const Profile(
        name: 'Seo Yen',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_seo_yen.jpg'),
    const Profile(
        name: 'Jisoo',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_jisoo.jpg'),
    const Profile(
        name: 'Ye ji',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_yeji.jpg'),

    const Profile(
        name: 'Yen Ji',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_yen.jpg'),
    const Profile(
        name: 'Suzy',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_suzy.jpg'),
    const Profile(
        name: 'Seo Yen',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_seo_yen.jpg'),
    const Profile(
        name: 'Jisoo',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_jisoo.jpg'),
    const Profile(
        name: 'Ye ji',
        distance: '10 miles away',
        imageAsset: 'assets/img/ic_yeji.jpg'),
  ];

  ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        draggableItems.removeLast();
        _animationController.reset();

        swipeNotifier.value = Swipe.none;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [

        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ValueListenableBuilder(
              valueListenable: swipeNotifier,
              builder: (context, swipe, _) => Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: List.generate(draggableItems.length, (index) {
                  if (index == draggableItems.length - 1) {
                    return PositionedTransition(
                      rect: RelativeRectTween(
                        begin: RelativeRect.fromSize(
                            const Rect.fromLTWH(0, 0, 580, 340),
                            const Size(580, 340)),
                        end: RelativeRect.fromSize(
                            Rect.fromLTWH(
                                swipe != Swipe.none
                                    ? swipe == Swipe.left
                                    ? -300
                                    : 300
                                    : 0,
                                0,
                                580,
                                340),
                            const Size(580, 340)),
                      ).animate(CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.easeInOut,
                      )),
                      child: RotationTransition(
                        turns: Tween<double>(
                            begin: 0,
                            end: swipe != Swipe.none
                                ? swipe == Swipe.left
                                ? -0.1 * 0.3
                                : 0.1 * 0.3
                                : 0.0)
                            .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve:
                            const Interval(0, 0.4, curve: Curves.easeInOut),
                          ),
                        ),
                        child: DragWidget(
                          profile: draggableItems[index],
                          index: index,
                          swipeNotifier: swipeNotifier,
                          isLastCard: true,
                        ),
                      ),
                    );
                  } else {
                    return DragWidget(
                      profile: draggableItems[index],
                      index: index,
                      swipeNotifier: swipeNotifier,
                    );
                  }
                }),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// DisLike Button
             /* ActionButtonWidget(
                onPressed: () {


                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              ),*/

              ///DisLike Section
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: IconButton(onPressed: (){
                    print("DisLike ${draggableItems[draggableItems.length-1].name}" );

                    swipeNotifier.value = Swipe.left;
                    _animationController.forward();
                  }, icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),),
                ),
              ),
              const SizedBox(width: 10),
              ///Like Section
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: IconButton(onPressed: (){

                    print("Like ${draggableItems[draggableItems.length-1].name}" );
                    swipeNotifier.value = Swipe.right;
                    _animationController.forward();

                  }, icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),),
                ),
              ),
              const SizedBox(width: 10),
              /// Poke
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: IconButton(onPressed: (){}, icon: const Icon(
                    Icons.back_hand,
                    color: Colors.blue,
                  ),),
                ),
              ),
          /*    ///Like Button
              ActionButtonWidget(
                onPressed: () {
                  print("Like ${draggableItems[draggableItems.length-1].name}" );
                  swipeNotifier.value = Swipe.right;
                  _animationController.forward();
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),*/
            ],
          ),
        ),
        /// Swipe DisLike Drag
        Positioned(
          left: 0,
          child: DragTarget<int>(
            builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
                ) {
              return IgnorePointer(
                child: Container(
                  height: 700.0,
                  width: 80.0,
                  color: Colors.transparent,
                ),
              );
            },
            onAccept: (int index) {
              setState(() {
                print(" DisLike $index");
                print("DisLike ${draggableItems[index].name}");
                draggableItems.removeAt(index);

              });
            },
          ),
        ),

        /// Swipe Like Drag
        Positioned(
          right: 0,
          child: DragTarget<int>(
            builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
                ) {
              return IgnorePointer(
                child: Container(
                  height: 700.0,
                  width: 80.0,
                  color: Colors.transparent,
                ),
              );
            },
            onAccept: (int index) {
              setState(() {
                print(" Like $index");
                print("Like ${draggableItems[index].name}");
                draggableItems.removeAt(index);

              });
            },
          ),
        ),

        Positioned(
          bottom: 0,
          child: DragTarget<int>(
            builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
                ) {
              return IgnorePointer(
                child: Container(
                  height: 700.0,
                  width: 80.0,
                  color: Colors.transparent,
                ),
              );
            },
            onAccept: (int index) {
              setState(() {
                print(" drag to top $index");


              });
            },
          ),
        ),
      ],
    );
  }
}

class ActionButtonWidget extends StatelessWidget {
  const ActionButtonWidget(
      {Key? key, required this.onPressed, required this.icon})
      : super(key: key);
  final VoidCallback onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: IconButton(onPressed: onPressed, icon: icon),
      ),
    );
  }
}






