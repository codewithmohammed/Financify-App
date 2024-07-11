import 'dart:io';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<dynamic> bottomsheet(AppTheme appTheme, BuildContext context,
    ProfileDataProvider profileDataProvider) {
  return showModalBottomSheet(
      context: context,
      builder: (builder) => Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                Text(
                  'Choose Profile Photo',
                  style: TextStyle(fontSize: 20, color: appTheme.mainTextColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () async {
                          final returnedcamera = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (returnedcamera != null) {
                            final fileImage = File(returnedcamera.path);
                            profileDataProvider.setProfilePic(fileImage);
                          } else {
                            const snackBar = SnackBar(
                              content: Text("You haven't selected an image"),
                              duration: Duration(seconds: 3),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text('Camera')),
                    ElevatedButton.icon(
                        onPressed: () async {
                          final returnedImage = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (returnedImage != null) {
                            final fileImage = File(returnedImage.path);
                            profileDataProvider.setProfilePic(fileImage);
                          } else {
                            const snackBar = SnackBar(
                              content: Text("You haven't selected an image"),
                              duration: Duration(
                                  seconds: 3), // Adjust the duration as needed
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        icon: const Icon(Icons.image),
                        label: const Text('Gallery'))
                  ],
                )
              ],
            ),
          ));
}

toSelectCurrency(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(
      context, 'CurrencySelect', (route) => false);
}
