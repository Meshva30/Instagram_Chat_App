
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../model/firebase_model.dart';
import 'google_services.dart';

class UserServices {
  static UserServices userServices = UserServices._();

  UserServices._();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(UserModel user) async {
    final CollectionReference userCollection = firestore.collection("User");
    await userCollection.doc(user.email).set(user.toMap(user));
  }

  Stream<QuerySnapshot> getUser(String email) {
    CollectionReference userCollection = firestore.collection("User");
    return userCollection
        .where('email',
        isNotEqualTo:
        GoogleSignInServices.googleSignInServices.currentUser()!.email)
        .snapshots();
  }

  Future<DocumentSnapshot<Object?>> getcurrentuser(User user) {
    final CollectionReference usercollection = firestore.collection("User");
    return usercollection.doc(user.email).get();
  }
}