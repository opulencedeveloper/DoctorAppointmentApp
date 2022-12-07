import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/doctors.dart';
import '../screens/chat_screen.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({Key? key}) : super(key: key);
  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final docData = Provider.of<Doctors>(context, listen: false);
    final docInfo = docData.doctors;
    final dynamic appBar = AppBar(
        backgroundColor: theme.primary,
        //automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 8,
        //titleSpacing: 0,
        title: const Text('Chat with Doctors', style: TextStyle(fontSize: 21, color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ]);
    return Scaffold(
      appBar: appBar,
      body: ListView.builder(
        itemCount: docInfo.length,
        itemBuilder: (context, i) => ListTile(
          onTap: () {
              Navigator.of(context).pushNamed(

              ChatScreen.routeName,

              arguments: {

                'firstName': docInfo[i].firstName,

    'lastName': docInfo[i].lastName,
    'imageUrl': docInfo[i].imageUrl,

                

              },

            );
            
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              docInfo[i].imageUrl,
            ),
          ),
          title: Text(
            '${docInfo[i].firstName} ${docInfo[i].lastName}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(docInfo[i].type),
        ),
      ),
    );
  }
}
