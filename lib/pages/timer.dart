import 'dart:convert';

import 'package:accident_tracker/pages/widgets/collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../common/common_dialogue.dart';

class AccidentTraker extends StatefulWidget {
  const AccidentTraker({Key? key}) : super(key: key);

  @override
  State<AccidentTraker> createState() => _AccidentTrakerState();
}

class _AccidentTrakerState extends State<AccidentTraker> {
  List<String> deviceTokens = [];
  QuerySnapshot<Map<String, dynamic>>? snapshot;

  sendNotification(
    String title,
    String description,
  ) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAArqaybDw:APA91bFoxKuXs3bOwBUfEWIql9qobXAbP9045KyomH68_pQngIdr6jn7I-YMN5RVVhD7zl_UJZ6cdEpsEtrOqwcVS30hCY0xOILz-2Zf5kq8cwM0gYTMKSaGcWknZXz5lW3Ce5X9qfah',
    };

    final payload = <String, dynamic>{
      // 'registration_ids': deviceTokens, // An array of device tokens
      'registration_ids': deviceTokens, // An array of device tokens
      'notification': {
        'title': title,
        'body': description,
      },
      'data': {'long': long, "lat": lat}
    };

    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: headers,
      body: json.encode(payload),
    );
    print(response.body);
  }

  getData() async {
    snapshot = await FirebaseFirestore.instance.collection("user").get();
    deviceTokens = [];
    for (int i = 0; i < snapshot!.docs.length; i++) {
      print(snapshot!.docs[0].data()["FCM_Token"].toString());
      deviceTokens.add(snapshot!.docs[i].data()["FCM_Token"].toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  double lat = 31.418715;
  double long = 73.079109;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          InkWell(
            onTap: () {
              showCustomDialogWithCancelButton(
                  onCancelButtonPressed: () {
                    Get.back();
                  },
                  context: context,
                  onButtonPressed: () async {
                    await Collections.accident_alerts.doc().set({
                      "title": "Accident Alert",
                      "Long": long.toString(),
                      "Lat": lat.toString(),
                      "time": DateTime.now(),
                    });
                    sendNotification(
                        "Accident Alert", "Long: $long  Lat: $lat ");
                    Get.back();
                  });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black),
                      color: Colors.black),
                  height: 100,
                  width: 100,
                  child: Center(
                      child: Text(
                    "Send Notification",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
