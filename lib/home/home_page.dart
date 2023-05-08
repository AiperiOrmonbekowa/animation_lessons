import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFulsun = false;
  bool isDayMood = true;
  Duration duration = const Duration(seconds: 5);

  Future<void> changeMode(int value) async {
    await Future.delayed(duration);
    if (value == 0) {
      setState(() {
        isFulsun = true;
      });
    } else {
      setState(() {
        isFulsun = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Future<void>.delayed(duration);
        await changeMode(0);
      },
    );
    changeMode(0);
  }

  @override
  Widget build(BuildContext context) {
    List<Color> lightColors = [
      const Color(0xFF8C248A),
      const Color(0xFFCE5870),
      const Color(0xFFd4f542),
      if (isFulsun) const Color(0xFFFF9089)
    ];

    List<Color> darkColors = [
      const Color(0xFF4251f5),
      const Color(0xFF283584),
      const Color(0xFF376AB2),
    ];

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AnimatedContainer(
        width: width,
        height: height,
        duration: duration,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isFulsun ? lightColors : darkColors,
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              bottom: isFulsun ? 320 : -150,
              left: 0,
              right: 0,
              duration: duration,
              child: SvgPicture.asset('assets/images/sun.svg'),
            ),
            Positioned(
              bottom: -30,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/land_tree_light.png',
                height: 430,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              width: width,
              margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              height: 60 + 09,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DefaultTabController(
                length: 2,
                child: TabBar(
                  onTap: (value) async {
                    changeMode(value);
                  },
                  indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  labelStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                  tabs: const [
                    Tab(text: 'day'),
                    Tab(text: 'night'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
