import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  // final Key myKey;
  const MessageBubble({
    Key? key,
    //  required this.myKey,
    required this.message,
    required this.isMe,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? theme.primary : Colors.grey[200],
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(12.0),
              bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(12.0),
              topLeft: const Radius.circular(12.0),
              bottomLeft: isMe ? const Radius.circular(12.0) : const Radius.circular(0),
            ),
          ),
          //width: 140,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Text(
            message,
            style: TextStyle(color: isMe ? Colors.white : Colors.black),
          ),
        ),
      ],
    );
  }
}
