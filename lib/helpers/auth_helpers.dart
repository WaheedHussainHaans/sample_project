import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample_project/helpers/image_helper.dart';
import 'package:sample_project/models/user_model.dart';
import 'package:sample_project/utils/firestore_collections.dart';

class AuthHelpers {
  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      print('firebaseAUth exception $e');
      return e.message;
    } catch (e) {
      print('Erro in signing in $e');
      return 'Something went wrong please try again later';
    }
  }

  Future<String> signUp(
      UserModel userModel, String password, File profilePic) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userModel.email, password: password);
      String imgUrl =
          await ImageHelper.uploadImageLatest(profilePic, 'profiles');
      userModel.profileImage = imgUrl;
      userModel.userId = userCredential.user.uid;
      await addFirstDataToFirestore(userModel);
      return null;
    } on FirebaseAuthException catch (e) {
      print('firebaseAUth exception $e');
      return e.message;
    } catch (e) {
      print('Erro in signing in $e');
      return 'Something went wrong please try again later';
    }
  }

  getCurrentUserData() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(KFirebaseCollections.users)
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get();
      if (documentSnapshot != null) {
        return UserModel.fromMap(documentSnapshot.data());
      } else
        return null;
    } catch (e) {
      print('Error in getting current User data $e');
      return null;
    }
  }

  addFirstDataToFirestore(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection(KFirebaseCollections.users)
        .doc(userModel.userId)
        .set(
          userModel.toMap(),
        );
  }
}
