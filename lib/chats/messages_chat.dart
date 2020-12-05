import 'package:chat_app/chats/messageBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 4.0,
            ),
          );
        }
        final documents = streamSnapshot.data.documents;
        return ListView.builder(
          reverse: true,
          itemCount: documents.length,
          itemBuilder: (ctx, index) => MessageBubble(
            documents[index]['text'],
            // documents[index]['userId'],
          ),
        );
      },
    );
  }
}
