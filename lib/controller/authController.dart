import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktokclone/model/user.dart' as model;
import 'package:tiktokclone/utils/constants.dart';
import 'package:tiktokclone/utils/utils.dart';

class AuthController extends ChangeNotifier {
  late File? _profileImage;

  File? get profileImage => _profileImage;

  // Exisiting user login
  Stream<User?> get authState => firebaseAuth.idTokenChanges();

  Stream<model.User?>? get user {
    return firebaseAuth.authStateChanges().map(
          (User? user) => (user != null)
              ? model.User(
                  name: user.displayName!, email: user.email!, uid: user.uid)
              : null,
        );
  }

  // Register User
  Future<void> registerUser(BuildContext context, String username, String email,
      String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // creating user account

        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        // storing profile image and obtaining its downloading url

        String profilePhotodownloadUrl = await _uploadProfilePhoto(image);

        // Extra information about user

        model.User user = model.User(
            name: username,
            profilePhoto: profilePhotodownloadUrl,
            email: email,
            uid: cred.user!.uid);

        await firebaseFirestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Utils.snackBar(context, 'Enter Valid Details!');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // upload profile photo to firebase storage
  Future<String> _uploadProfilePhoto(File image) async {
    try {
      Reference reference = await firebaseStorage
          .ref()
          .child('profilePhoto')
          .child(firebaseAuth.currentUser!.uid);
      UploadTask uploadTask = reference.putFile(image);
      TaskSnapshot upload = await uploadTask.whenComplete(() => null);
      String profilePhotoUrl = await upload.ref.getDownloadURL();
      return profilePhotoUrl;
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    throw {};
  }

  // choosing image from gallery

  Future<void> pickImage() async {
    final selectedImage =
        (await ImagePicker().pickImage(source: ImageSource.gallery));
    if (selectedImage != null) {
      _profileImage = File(selectedImage!.path);
      debugPrint('image selected');
      notifyListeners();
    } else {
      debugPrint('image not selected');
      return;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // notifyListeners();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
      
      await firebaseAuth.currentUser;
      notifyListeners();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
