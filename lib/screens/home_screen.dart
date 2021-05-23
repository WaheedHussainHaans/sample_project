import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_project/models/user_model.dart';
import 'package:sample_project/screens/auth_screens/login_screen.dart';
import 'package:sample_project/utils/firestore_collections.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Get.offAll(LoginScreen());
            },
          )
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(KFirebaseCollections.users)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  UserModel userModel =
                      UserModel.fromMap(snapshot.data.docs[index].data());
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userModel.profileImage),
                    ),
                    title: Text(userModel.userName),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
