import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class ThirdPartyModule {
  @preResolve
  Future<SharedPreferences> sharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  FlutterSecureStorage secureStorage() {
    return FlutterSecureStorage();
  }

  FirebaseAuth firebaseAuth() {
    return FirebaseAuth.instance;
  }

  FirebaseFirestore firebaseFirestore() {
    return FirebaseFirestore.instance;
  }
}
