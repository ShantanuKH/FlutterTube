import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/auth/pages/login_page.dart';
import 'package:youtube_clone/features/auth/pages/username_page.dart';
import 'package:youtube_clone/firebase_options.dart';
import 'package:youtube_clone/home_page.dart';

void main() async {
  // To connect the porject to the firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterTube',

      // To check wheather we are signin or not we can use StreamBuilder
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LoginPage();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader();
            }

            // After loading the data and after we have the we wil return the second stream builder
            // To check wheather data is added to the databse or not
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                final user = FirebaseAuth.instance.currentUser;
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return UsernamePage(
                      displayName: user!.displayName!,
                      profilePic: user!.photoURL!,
                      email: user!.email!);
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Loader();
                }
                return HomePage();
              },
            );
          }),
    );
  }
}
