import 'package:chat_app/chats/messageBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: FirebaseAuth.instance.currentUser,
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
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
              final doc = streamSnapshot.data.documents;
              return ListView.builder(
                reverse: true,
                itemCount: doc.length,
                itemBuilder: (ctx, index) => MessageBubble(
                  doc[index]['text'],
                  doc[index]['userId'] == futureSnapshot.data.uid,
                  // key: ValueKey(doc[index].documentId),
                ),
              );
            });
      },
    );
  }
}
