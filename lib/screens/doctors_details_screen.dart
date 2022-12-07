import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/doctors.dart';
import '../screens/bookings_screen.dart';
import './video_call_screen.dart';
import '../screens/chat_screen.dart';

class DoctorsDetailsScreen extends StatelessWidget {
  static const routeName = '/route-name';

  const DoctorsDetailsScreen({Key? key}) : super(key: key);
  void check() {
    print("runApp2");
  }

  @override
  Widget build(BuildContext context) {
    final doctorId = ModalRoute.of(context)!.settings.arguments.toString();
    final loadedDoctor = Provider.of<Doctors>(context, listen: false).findById(doctorId);
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).colorScheme;
    final dynamic appBar = AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade100,
                  width: 3,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(5),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(width: mediaQuery.size.width * 0.15),
          const Text(
            "Doctor's Profile",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      bottomNavigationBar: Container(
        color: theme.primary,
        height: 50,
        //margin: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
        child: TextButton(
          child: const Text(
            "Book an appointment",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(BookingsScreen.routeName, arguments: doctorId);
          },
        ),
      ),
      appBar: appBar,
      body: SafeArea(
        child: Container(
          height: mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight,
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        13,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: LayoutBuilder(builder: (ctx, constraints) {
                    return Column(children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.7,
                        child: LayoutBuilder(builder: (ctx, constraints) {
                          return Row(children: [
                            Container(
                              width: constraints.maxWidth * 0.33,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              child: FittedBox(
                                // alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    loadedDoctor.imageUrl,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.05,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: constraints.maxWidth * 0.08),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      '${loadedDoctor.firstName} ${loadedDoctor.lastName}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      loadedDoctor.type,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const Text(
                                      "Cambridge hospital, Lagos Nigeria",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]);
                        }),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.23,
                        child: LayoutBuilder(builder: (ctx, constraints) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 21,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: IconButton(
                                    icon: const Icon(Icons.phone, color: Colors.black),
                                    onPressed: () {
                                      final Uri _url = Uri.parse('tel:+2348184297165');
                                      launchUrl(_url);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.02,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 21,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: IconButton(
                                    icon: const Icon(Icons.chat_outlined, color: Colors.black),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(ChatScreen.routeName, arguments: {
                                        'firstName': loadedDoctor.firstName,
                                        'lastName': loadedDoctor.lastName,
                                        'imageUrl': loadedDoctor.imageUrl,
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.02,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 21,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: IconButton(
                                    icon: const Icon(Icons.video_call, color: Colors.black),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(VideoCall.routeName);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.05,
                      ),
                    ]);
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                  child: LayoutBuilder(builder: (ctx, constraints) {
                    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.shade100,
                              width: 3,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(Icons.star, color: Colors.yellow, size: 11),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.01,
                      ),
                      SizedBox(
                          width: constraints.maxWidth * 0.3,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text(
                              "Rating",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${loadedDoctor.rating} out of 5.0',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ])),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.shade100,
                              width: 3,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Icon(Icons.group, color: theme.primary, size: 13),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.01,
                      ),
                      Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const Text(
                          "Patients",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${loadedDoctor.patients}+',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ])),
                    ]);
                  }),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'About ${loadedDoctor.firstName}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 90,
                  child: Text(
                    '${loadedDoctor.firstName} is a top specialist at Cambridge Hospital, he has been in the profession for over 10 years, He is trained all aspect of cardiolody and has received several awards and recognition for his contribution and service in his own field, he is available for private consultaion',
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Services",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(
                  height: 80,
                  child: Text(
                    "Treat a myraid of nurological conditions, including stroke, seizures, movement disorders such as Pakinson's diseases,autoimmume neurological disorder",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Working time",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 20,
                  child: Text(
                    "Mondays - Fridays (08:00 AM - 09:00 PM)",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Fees",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  height: 28,
                  child: Text(
                    '\$${loadedDoctor.fee}',
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                const SizedBox(
                  height: 13,
                ),
                const Text(
                  "Reviews",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 60,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    minVerticalPadding: 0,
                    //visualDensity: VisualDensity(vertical: 2),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(Icons.person, color: Colors.grey),
                    ),
                    title: const Text(
                      'James Chukwu',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: SizedBox(
                      height: 10,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, builder) => const Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Thank God for the heal me app. ${loadedDoctor.firstName} is my favourite Doxctor',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 60,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    minVerticalPadding: 0,
                    //visualDensity: VisualDensity(vertical: 2),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(Icons.person, color: Colors.grey),
                    ),
                    title: const Text(
                      'Anita Cruz',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: SizedBox(
                      height: 10,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, builder) => const Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'The major thing about. ${loadedDoctor.firstName} is keeping to time and alaways available for facetime',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
