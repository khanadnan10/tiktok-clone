import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/user.dart';
import '../../utils/constants.dart';

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;

  AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Stream<fbAuth.User?> get user => firebaseAuth.userChanges();

  Future<String> _uploadProfilePhoto(File? image) async {
    try {
      Reference reference = await firebaseStorage
          .ref()
          .child('profilePhoto')
          .child(firebaseAuth.currentUser!.uid);
      UploadTask uploadTask = reference.putFile(image!);
      TaskSnapshot upload = await uploadTask.whenComplete(() => null);
      String profilePhotoUrl = await upload.ref.getDownloadURL();
      return profilePhotoUrl;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    throw {print("Error while uploading profile photo!")};
  }

  Future<void> signup(
    String username,
    String email,
    String password,
    File? image,
  ) async {
    try {
      final fbAuth.UserCredential cred = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final signedInUser = cred.user!;

      String profilePhotodownloadUrl = await _uploadProfilePhoto(image!);

      User user = User(
          name: username,
          profilePhoto: profilePhotodownloadUrl,
          email: email,
          uid: cred.user!.uid);

      await firebaseFirestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(user.toJson());
    } on fbAuth.FirebaseAuthException catch (e) {
      debugPrint(e.message);
      debugPrint(e.code);
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {}
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on fbAuth.FirebaseAuthException catch (e) {
      debugPrint("Error in signin: ${e.message}" + " ${e.code}");
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
