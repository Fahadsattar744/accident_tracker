import 'dart:ui';

import 'package:flutter/material.dart';

Future<void> showCustomDialogWithCancelButton({
  required BuildContext context,
  required VoidCallback onButtonPressed,
  required VoidCallback onCancelButtonPressed,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // Close the dialog
        },
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: AlertDialog(
                  backgroundColor: Colors.black.withOpacity(0.1),
                  elevation: 0,
                  contentPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.black.withOpacity(0.3)),
                  ),
                  actions: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "Are you sure you want to send Alert",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                onButtonPressed();
                              },
                              child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.white),
                                  // color:
                                  //     AppColors.primaryColor.withOpacity(0.8)
                                ),
                                child: Center(
                                    child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            InkWell(
                              onTap: () {
                                onCancelButtonPressed();
                              },
                              child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.white),
                                  // color:
                                  //     AppColors.primaryColor.withOpacity(0.8)
                                ),
                                child: Center(
                                    child: Text(
                                  "No",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      );
    },
  );
}
