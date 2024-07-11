import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/channel/my_channel/pages/user_channel/pages/user_channel_page.dart';
import 'package:youtube_clone/features/auth/pages/channel_settings.dart';
import 'package:youtube_clone/features/auth/pages/login_page.dart';
import 'package:youtube_clone/features/channel/my_channel/pages/my_channel_screen.dart';
import 'package:youtube_clone/features/auth/pages/username_page.dart';
import 'package:youtube_clone/features/upload/long_video/video_details_page.dart';
import 'package:youtube_clone/firebase_options.dart';
import 'package:youtube_clone/home_page.dart';

void main() async {
  // To connect the project to Firebase
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

      // To check whether we are signed in or not, we can use StreamBuilder
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LoginPage();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }

            // After loading the data and after we have the user, we will return the second StreamBuilder
            // To check whether data is added to the database or not
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
                      profilePic: user.photoURL!,
                      email: user.email!);
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }
                return HomePage();
              },
            );
          }),
    );
  }
}
