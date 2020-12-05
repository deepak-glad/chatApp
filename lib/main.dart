
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'screens/chat_screen.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.teal,
        errorColor: Colors.red,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.green,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        )
      ),
      // home: AuthScreen(),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (context, snapshot) {
        if(snapshot.hasData){
          return ChatScreen();
        }
        return AuthScreen();
      } ,),
    );
  }
}
