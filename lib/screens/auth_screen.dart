import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' show FirebaseStorage;
import 'package:firebase_auth/firebase_auth.dart' show AuthResult, FirebaseAuth;
import 'package:cloud_firestore/cloud_firestore.dart' show Firestore;
import 'package:flutter/services.dart' show PlatformException;
import '../components/constants.dart';
import '../components/widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _submitAuthForm({
    String email,
    String password,
    String username,
    File userImageFile,
    bool isLogin,
    BuildContext context,
  }) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(authResult.user.uid + '.jpg');

        await ref.putFile(userImageFile).onComplete;

        final url = await ref.getDownloadURL();

        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData(
          {
            'username': username,
            'email': email,
            'image_url': url,
          },
        );
      }
    } on PlatformException catch (e) {
      String message = 'An error occured, please check your credentials';
      if (e.message != null) {
        message = e.message;
      }
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: AuthForm(submitFn: _submitAuthForm, isLoading: _isLoading),
    );
  }
}
