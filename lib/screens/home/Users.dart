import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              return SafeArea(
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Registered Students',
                      style: TextStyle(fontSize: 32, color: Colors.grey[800]),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 50, 0, 0),
                    child: ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return ListTile(
                          title: Text(document['email']),
                        );
                      }).toList(),
                    ),
                  ),
                ]),
              );
          }
        }));
  }
}
