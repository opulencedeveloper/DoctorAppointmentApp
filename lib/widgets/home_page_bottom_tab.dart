import 'package:flutter/material.dart';

import '../tabs/all.dart';
import '../tabs/cardiology.dart';
import '../tabs/neurology.dart';
import '../tabs/dentistry.dart';
import '../tabs/surgeon.dart';

class HomePageBottomTab extends StatefulWidget {
  const HomePageBottomTab({Key? key}) : super(key: key);
  @override
  _HomePageBottomTabState createState() => _HomePageBottomTabState();
}

class _HomePageBottomTabState extends State<HomePageBottomTab> {
  // var color = 0;
  int pageChanged = 0;
  final controller = PageController(initialPage: 0);

  void _all() {
    controller.animateToPage(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  void _cardiology() {
    controller.animateToPage(
      1,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  void _neurology() {
    controller.animateToPage(
      2,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  void _surgeon() {
    controller.animateToPage(
      3,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  void _dentist() {
    controller.animateToPage(
      4,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabController? _tabController;
    final theme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final tabHeight = (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.2;
    final tabWidth = mediaQuery.size.width * 0.27;
    Widget tabb(String type, String number, String name, String imageUrl, int pa) {
      return LayoutBuilder(builder: (ctx, constraints) {
        return Container(
          width: 100,
          decoration: BoxDecoration(color: pa == 0 ? theme.primary : Colors.grey[350], borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.17,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.3,
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.1,
              ),
              SizedBox(
                // height: constraints.maxHeight * 0.1,
                child: FittedBox(
                  child: Text(
                    type,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: pa == 1 ? theme.secondary : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.03,
              ),
              SizedBox(
                // constraints.maxHeight * 0.1,
                child: FittedBox(
                  child: Text(
                    "$number $name",
                  ),
                ),
              ),
            ],
          ),
        );
      });
    }

    //  print(_tabController);
    return Column(children: <Widget>[
      Container(
        height: 120,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            GestureDetector(
                child: Container(
                    width: 100,
                    decoration: BoxDecoration(color: pageChanged == 0 ? theme.primary : Colors.grey[100], borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: LayoutBuilder(builder: (ctx, constraints) {
                      return Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.17,
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.3,
                            child: Image.asset(
                              'assets/images/d2.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.1,
                          ),
                          SizedBox(
                            // height: constraints.maxHeight * 0.1,
                            child: FittedBox(
                              child: Text(
                                "All",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: pageChanged == 0 ? theme.secondary : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.03,
                          ),
                          SizedBox(
                            // constraints.maxHeight * 0.1,
                            child: FittedBox(
                              child: Text(
                                "1000 Doctors",
                                style: TextStyle(
                                  color: pageChanged == 0 ? theme.secondary : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    })),
                onTap: _all),
            SizedBox(
              width: mediaQuery.size.width * 0.02,
            ),
            GestureDetector(
                child: Container(
                    width: 100,
                    decoration: BoxDecoration(color: pageChanged == 1 ? theme.primary : Colors.grey[100], borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: LayoutBuilder(builder: (ctx, constraints) {
                      return Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.17,
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.3,
                            child: Image.asset(
                              'assets/images/d3.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.1,
                          ),
                          SizedBox(
                            // height: constraints.maxHeight * 0.1,
                            child: FittedBox(
                              child: Text(
                                'Cardiology',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: pageChanged == 1 ? theme.secondary : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.03,
                          ),
                          SizedBox(
                            // constraints.maxHeight * 0.1,
                            child: FittedBox(
                              child: Text(
                                "300 Doctors",
                                style: TextStyle(
                                  color: pageChanged == 1 ? theme.secondary : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    })),
                onTap: _cardiology),
            SizedBox(
              width: mediaQuery.size.width * 0.02,
            ),
            GestureDetector(
                child: Container(
                    width: 100,
                    decoration: BoxDecoration(color: pageChanged == 2 ? theme.primary : Colors.grey[100], borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: LayoutBuilder(builder: (ctx, constraints) {
                      return Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.17,
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.3,
                            child: Image.asset(
                              'assets/images/d6.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.1,
                          ),
                          SizedBox(
                            // height: constraints.maxHeight * 0.1,
                            child: FittedBox(
                              child: Text(
                                'Neurology',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: pageChanged == 2 ? theme.secondary : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.03,
                          ),
                          SizedBox(
                            // constraints.maxHeight * 0.1,
                            child: FittedBox(
                              child: Text(
                                "300 Doctors",
                                style: TextStyle(
                                  color: pageChanged == 2 ? theme.secondary : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    })),
                onTap: _neurology),
            SizedBox(
              width: mediaQuery.size.width * 0.02,
            ),
            GestureDetector(
                child: Container(
                    width: 100,
                    decoration: BoxDecoration(color: pageChanged == 3 ? theme.primary : Colors.grey[100], borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: LayoutBuilder(builder: (ctx, constraints) {
                      return Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.17,
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.3,
                            child: Image.asset(
                              'assets/images/d5.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.1,
                          ),
                          SizedBox(
                            // height: constraints.maxHeight * 0.1,
                            child: FittedBox(
                              child: Text(
                                'Surgeon',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: pageChanged == 3 ? theme.secondary : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.03,
                          ),
                          SizedBox(
                            // constraints.maxHeight * 0.1,
                            child: FittedBox(
                              child: Text(
                                "300 Doctors",
                                style: TextStyle(
                                  color: pageChanged == 3 ? theme.secondary : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    })),
                onTap: _surgeon),
            SizedBox(
              width: mediaQuery.size.width * 0.02,
            ),
            GestureDetector(
                child: Container(
                    width: 100,
                    decoration: BoxDecoration(color: pageChanged == 4 ? theme.primary : Colors.grey[100], borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: LayoutBuilder(builder: (ctx, constraints) {
                      return Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.17,
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.3,
                            child: Image.asset(
                              'assets/images/d4.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.1,
                          ),
                          SizedBox(
                            // height: constraints.maxHeight * 0.1,
                            child: FittedBox(
                              child: Text(
                                'Dentist',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: pageChanged == 4 ? theme.secondary : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.03,
                          ),
                          SizedBox(
                            // constraints.maxHeight * 0.1,
                            child: FittedBox(
                              child: Text(
                                "300 Doctors",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: pageChanged == 4 ? theme.secondary : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    })),
                onTap: _dentist),
          ],
        ),
      ),
      SingleChildScrollView(
          child: Container(
              height: (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.7,
              padding: const EdgeInsets.symmetric(
                vertical: 25,
              ),
              child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      pageChanged = index;
                    });

                    print(index);
                  },
                  controller: controller,
                  children: [
                    const All(),
                    const Cardiology(),
                    const Neurology(),
                    const Dentistry(),
                    const Surgeon(),
                  ])))
    ]);
  }
}
