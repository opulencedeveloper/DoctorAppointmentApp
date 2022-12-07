import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:url_launcher/url_launcher.dart';
//import 'firebase_options.dart';
import '../widgets/chat/messages.dart';
import '../widgets/chat/new_messages.dart';
import './video_call_screen.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = "/chat-route-name";

  const ChatScreen({Key? key}) : super(key: key);
  @override
  ChatScreenScreenState createState() => ChatScreenScreenState();
}

class ChatScreenScreenState extends State<ChatScreen> {
  var _loadedInitData = false;

  var _firstName = '';

  var _secondName = '';
  var _imageUrl = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loadedInitData) {
      final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;

      _firstName = routeArgs['firstName'] as String;
      _secondName = routeArgs['lastName'] as String;

      _imageUrl = routeArgs['imageUrl'] as String;
      print('route');
    }

    _loadedInitData = true;
  }
  //@override
  //initState() {
  //  super.initState();
  //super.initState();
  //print("started");
  // Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Provider.of<Doctors>(context, listen: false).getting();
//  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final dynamic appBar = AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
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
              const SizedBox(width: 10),
              CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 21,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(_imageUrl),
                    radius: 20,
                  )),
              const SizedBox(width: 10),
              Text('${_firstName} ${_secondName}', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.black),
            onPressed: () {
              final Uri _url = Uri.parse('tel:+2348184297165');

              launchUrl(_url);
            },
          ),
          IconButton(
            icon: const Icon(Icons.video_call, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pushNamed(VideoCall.routeName);
            },
          ),
        ]);

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SizedBox(
          height: mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top,
          child: Column(
            children: const [
              Expanded(
                child: Messages(),
              ),
              NewMessage(),
            ],
          ),
        ),
      ),
    );
  }
}
