import 'package:clone/providers/user_provider.dart';
import 'package:clone/responsive/mobile_screen_layout.dart';
import 'package:clone/responsive/responsive_layout_screen.dart';
import 'package:clone/responsive/web_screen_layout.dart';
import 'package:clone/screens/login_screen.dart';
import 'package:clone/screens/signup_screen.dart';
import 'package:clone/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    //to check which platform it is on
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyApEVvBWLcBW5otw1YMKkSDSSQQ8wTi0LQ',
          appId: '1:461801259493:web:77308c55572aaa652bef0c',
          messagingSenderId: '461801259493',
          projectId: '1:461801259493:web:77308c55572aaa652bef0c',
          storageBucket:
              'clone-pyro.appspot.com' //we need to pass in theis parameter, since we need to store, or else it will show error in future
          ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:
            false, //the banner that shows up in top right corner wont show now
        title: 'clone',
        theme: ThemeData.dark().copyWith(
          // want to keep them and change the background color
          scaffoldBackgroundColor: mobileBackgroundColor,
        ), //all the features that flutter has put in dark mode
        //wrapped with scaffold

        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            return const LoginScreenState();
          },
        ),
      ),
    );
  }
}
