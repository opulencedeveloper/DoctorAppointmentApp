import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../widgets/home_page_bottom_tab.dart';
import '../provider/doctors.dart';
import '../provider/auth.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  // Future<dynamic>? _allDoctorFuture;
  // Future _obtainAllDoctorFuture() {
  //   return Provider.of<Doctors>(context, listen: false).fetchAndSetMyDoc();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _allDoctorFuture = _obtainAllDoctorFuture();
  //   Provider.of<Auth>(context, listen: false).fetchAndSetUserName();
  // }

  @override
  Widget build(BuildContext context) {
    print("home");
    final theme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final userName = Provider.of<Auth>(context).useName;
    final userId = Provider.of<Auth>(context).userId;
    return Container(
      alignment: Alignment.center,
      height: (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight),
      padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 30,
                  child: const FittedBox(
                    child: Text(
                      'Hello!',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                            height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      //offset: Offset(0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                  child:     Badge(
                        animationType: BadgeAnimationType.fade,
                        padding: EdgeInsets.all(4),
                        //toAnimate: false,
                        badgeContent: const Text("0", style:TextStyle(fontSize: 10)
                                                ),
                        badgeColor: Colors.red,
                        position: BadgePosition.topEnd(top: 3, end: 5),
                        child: const Icon(Icons.notifications, size:30
                                         ),
                      ),
                    ),
                  
                
              ],
            ),

                                

                                

                                
                                  
                                  

                                                         

                                      
                                      
                                      

                                      //offset: Offset(0, 1), // changes position of shadow

                              

                                  
                              
            const Text(
              'Chat and call doctors 24/7',
              style: const TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // GestureDetector(
            TextField(
              readOnly: true,
              enableInteractiveSelection: false, // will disable paste operation
              //enabled: false,
              //focusNode: new AlwaysDisabledFocusNode(),
              //autofocus: false,
              decoration: InputDecoration(
                labelText: 'Search',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                ),
                suffixIcon: const Icon(
                  Icons.mic,
                ),
              ),
              onTap: () {
                print('tapped');
                FocusScope.of(context).unfocus();
              },
              // onChanged: (val) => amountInput = val,
            ),
            // onTap: () {
            //   print('gesture');
            // }),
            const SizedBox(
              height: 28,
            ),
            Container(
              height: 120,
              color: theme.primary,
              child: Row(
                children: [
                  Container(
                    width: mediaQuery.size.width * 0.55,
                    padding: EdgeInsets.symmetric(
                      vertical: 17,
                      horizontal: mediaQuery.size.width * 0.02,
                    ),
                    child: LayoutBuilder(builder: (ctx, constraints) {
                      return Column(
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.5,
                            child: FittedBox(
                              child: Center(
                                child: Text(
                                  "COVID 19 is real\nGet your vaccine",
                                  style: TextStyle(
                                    color: theme.secondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.1,
                          ),
                          SizedBox(
                            //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                            height: constraints.maxHeight * 0.4,
                            width: constraints.maxWidth * 0.8,
                            child: ElevatedButton(
                              child: const Text("Click Me"),
                              style: ElevatedButton.styleFrom(
                                primary: theme.secondary,
                                onPrimary: theme.primary,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  Image.asset(
                    'assets/images/d1.png',
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              // height: 500,
              child: const HomePageBottomTab(),
            )
          ],
        ),
      ),
    );
  }
}
