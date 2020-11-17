import 'package:flutter_fire/screens/home/Users.dart';
import 'package:flutter_fire/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  Future addUser() async {
    final firestoreInstance = FirebaseFirestore.instance;
    User firebaseUser = FirebaseAuth.instance.currentUser;

    await firestoreInstance
        .collection('Users')
        .doc(firebaseUser.uid)
        .set({'email': firebaseUser.email});
  }

  

  @override
  Widget build(BuildContext context) {
    addUser();
    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Flutter Fire'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body:Users() ,
      ),
    );
  }
}

