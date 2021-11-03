import 'dart:convert';
import 'dart:math';

import 'package:avy/models/custom_timestamp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// This is one way to do it but we prefer FutureBuilder
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: FutureBuilder(
            future: _firebaseApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              } else {
                if (snapshot.hasData) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('emoji'),
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        final timeStamp = {
                          'emoji': emojis[Random().nextInt(emojis.length)],
                          'timeStamp': Timestamp.fromDate(DateTime.now()),
                        };
                        FirebaseFirestore.instance
                            .collection('custom')
                            .add(timeStamp);
                      },
                      child: const Text('🥦'),
                    ),
                    body: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('custom')
                          .snapshots(),
                      builder: (
                        context,
                        AsyncSnapshot<QuerySnapshot> _snapshot,
                      ) {
                        if (!_snapshot.hasData) {
                          return const Text('No data');
                        }
                        return ListView.builder(
                          itemCount: _snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final CustomTimeStamp _timeStamp =
                                CustomTimeStamp.fromJson(
                              {
                                'emoji': _snapshot.data!.docs[index]['emoji'],
                                'timeStamp': _snapshot.data!.docs[index]
                                    ['timeStamp'],
                              },
                            );
                            return CustomCard(timeStamp: _timeStamp);
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return const Scaffold(
                    body: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ),
                  );
                }
              }
            }),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required CustomTimeStamp timeStamp,
  })  : _timeStamp = timeStamp,
        super(key: key);

  final CustomTimeStamp _timeStamp;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 6.0,
      ),
      child: ListTile(
        leading: Text(_timeStamp.emoji),
        title: Text(
          _timeStamp.timeStamp.toDate().toLocal().toString(),
        ),
      ),
    );
  }
}
