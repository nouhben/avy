import 'package:avy/screens/auth/auth_widget_builder.dart';
import 'package:avy/services/firebase_auth_service.dart';

import 'package:avy/services/image_picker_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/auth/auth_widget.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

// This is one way to do it but we prefer FutureBuilder
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: MultiProvider(
        providers: [
          Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),
          Provider<ImagePickerService>(create: (_) => ImagePickerService()),
        ],
        child: AuthWidgetBuilder(
          builder: (context, snapshot) {
            return MaterialApp(
              title: 'Flutter Provider Guide',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.deepPurple,
              ),
              home: AuthWidget(userSnapshot: snapshot),
            );
          },
        ),
      ),
    );
  }
}
