import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import './message_bubble.dart';
import "package:doctorapp/provider/auth.dart";

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<Auth>(context, listen: false).userId;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, AsyncSnapshot streamSnapShot) {
        if (!streamSnapShot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var documents = streamSnapShot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: streamSnapShot.data.docs.length,
          itemBuilder: (context, index) => MessageBubble(
            message: documents[index]['text'],
            isMe: documents[index]['userId'] == Provider.of<Auth>(context, listen: false).userId,
            //myKey: ValueKey(documents[index].documentID),
          ),
        );
      },
    );
  }
}
