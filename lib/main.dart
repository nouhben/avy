import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
                return Center(child: Text(snapshot.error.toString()));
              } else {
                if (snapshot.hasData) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Firebase'),
                    ),
                    floatingActionButton: FloatingActionButton(
                      isExtended: true,
                      child: const Icon(Icons.add_alert),
                      onPressed: () =>
                          FirebaseFirestore.instance.collection('testing').add(
                        {
                          'Timestamp': Timestamp.fromDate(
                            DateTime.now(),
                          ),
                        },
                      ),
                    ),
                    body: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('testing')
                          .snapshots(),
                      builder: (
                        context,
                        AsyncSnapshot<QuerySnapshot> snapshot,
                      ) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data!.docs[index];
                            final _dateTime =
                                (data['Timestamp'] as Timestamp).toDate();
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 5.0,
                              ),
                              child: ListTile(
                                selectedTileColor:
                                    Colors.purpleAccent.withOpacity(0.3),
                                isThreeLine: false,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: const BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                title: Text(
                                  _dateTime.toString(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }
            }),
      ),
    );
  }
}
