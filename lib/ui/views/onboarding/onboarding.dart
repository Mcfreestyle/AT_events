import 'package:at_events/ui/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'assets/onboarding/viewOne.png',
  'assets/onboarding/viewTwo.png',
  'assets/onboarding/viewThree.png',
];

final themeMode = ValueNotifier(2);

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value, g) {
        return MaterialApp(
          theme: ThemeData(
            canvasColor: Color(0xFFFFFFFF),
          ),
          home: CarouselWithIndicatorDemo(),
          themeMode: ThemeMode.values.toList()[value as int],
          debugShowCheckedModeBanner: false,
        );
      },
      valueListenable: themeMode,
    );
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          //padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Center(
              child: Image.asset(
            item,
            fit: BoxFit.fill,
          )),
        ))
    .toList();

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  viewportFraction: 2,
                  height: double.infinity,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  })),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 65.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Color(0xFFFF3265))
                        .withOpacity(_current == entry.key ? 0.9 : 0.2)),
              ),
            );
          }).toList(),
        ),
        Container(
          margin: new EdgeInsets.symmetric(horizontal: 25.0),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: ButtonWidget(
              title: 'Empezar',
              type: 'primary',
              function: () {
                /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );*/
                Navigator.pushReplacementNamed(context, 'login_view');
              },
            ),
          ),
        ),

        /* Container(
          child: Column(children: [
            MaterialButton(
              minWidth: 160.0,
              height: 40.0,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginView()));
                //  Navigator.pushNamed(context, 'login_view');
              },
              color: MyColor.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // <-- Radius
              ),
              child: Text('Empezar',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal)),
            ),
          ]),
        ),*/
        const SizedBox(
          height: 25,
        ),
      ]),
    );
  }
}








/*
import 'package:at_events/ui/theme/colors.dart';
import 'package:at_events/ui/views/login/login_view.dart';
import 'package:at_events/ui/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'assets/onboarding/viewOne.png',
  'assets/onboarding/viewTwo.png',
  'assets/onboarding/viewThree.png',
];

final themeMode = ValueNotifier(2);

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value, g) {
        return MaterialApp(
          theme: ThemeData(
            canvasColor: Color(0xFFFFFFFF),
          ),
          home: CarouselWithIndicatorDemo(),
          themeMode: ThemeMode.values.toList()[value as int],
          debugShowCheckedModeBanner: false,
        );
      },
      valueListenable: themeMode,
    );
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          //padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          child: Center(
              child: Image.asset(
            item,
            fit: BoxFit.fill,
          )),
        ))
    .toList();

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  viewportFraction: 2,
                  height: double.infinity,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  })),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 65.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Color(0xFFFF3265))
                        .withOpacity(_current == entry.key ? 0.9 : 0.2)),
              ),
            );
          }).toList(),
        ),
        Container(
          margin: new EdgeInsets.symmetric(horizontal: 25.0),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: ButtonWidget(
              title: 'Empezar',
              type: 'primary',
              function: () {
                /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );*/
                Navigator.pushReplacementNamed(context, 'login_view');
              },
            ),
          ),
        ),

        /* Container(
          child: Column(children: [
            MaterialButton(
              minWidth: 160.0,
              height: 40.0,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginView()));
                //  Navigator.pushNamed(context, 'login_view');
              },
              color: MyColor.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // <-- Radius
              ),
              child: Text('Empezar',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal)),
            ),
          ]),
        ),*/
        const SizedBox(
          height: 25,
        ),
      ]),
    );
  }
}

 */