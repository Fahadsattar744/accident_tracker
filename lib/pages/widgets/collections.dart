import 'package:cloud_firestore/cloud_firestore.dart';

class Collections {
  static var accident_alerts =
      FirebaseFirestore.instance.collection('accident_alerts');
}
