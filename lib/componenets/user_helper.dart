import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp/componenets/user.dart';

class UserServices {
  String collection = 'users';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void createUser(Map<String, dynamic> values) {
    String id = values['id'];
    _firebaseFirestore.collection(collection).doc(id).set(values);
  }

  void updateData(Map<String, dynamic> values) {
    _firebaseFirestore.collection(collection).doc(values['id']).update(values);
  }

  Future<UserModel> getUserById(String id) {
    return _firebaseFirestore.collection(collection).doc(id).get().then(
          (doc) { return UserModel.fromSnapshot(doc);},
        );
  }
}
