import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import "package:doctorapp/provider/auth.dart";

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enteredMessage = '';
  final _controller = TextEditingController();

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    //final user = Provider.of<Auth>(context, listen: false).userId;

    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createAt': Timestamp.now(), //Timestamp.now is from cloud firestore package
      'userId': Provider.of<Auth>(context, listen: false).userId,
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Send a message....',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
              ),
            ),
            IconButton(
              color: theme.primary,
              onPressed: _enteredMessage.isEmpty ? null : _sendMessage,
              icon: const Icon(Icons.send),
            ),
          ],
        ));
  }
}
