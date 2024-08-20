import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:financify/providers/profile_provider.dart';

import 'package:financify/utils/images.dart';
import 'package:financify/theme/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileUpdateScreen extends StatelessWidget {
  const ProfileUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    final nameKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: appTheme.backgroundColor,
        body: Consumer<ProfileDataProvider>(
          builder: ((context, profiledataprovider, child) => SafeArea(
                child: Stack(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'CLOSE',
                            style: TextStyle(color: appTheme.primaryColor),
                          )),
                      TextButton(
                          onPressed: () async {
                            if (nameKey.currentState!.validate() &&
                                profiledataprovider.imageData != null) {
                              profiledataprovider.setProfileName(
                                  profiledataprovider.nameController.text
                                      .toString());
                              profiledataprovider.profileToBD();
                              FocusScope.of(context).unfocus();
                              await Future.delayed(
                                      const Duration(milliseconds: 200))
                                  .then((value) => Navigator.of(context).pop());
                            } else {
                              return;
                            }
                          },
                          child: Text(
                            'UPDATE',
                            style: TextStyle(color: appTheme.primaryColor),
                            textAlign: TextAlign.right,
                          )),
                    ],
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Set up your',
                            style: TextStyle(color: appTheme.mainTextColor)),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Profile Picture',
                            style: TextStyle(
                                color: appTheme.mainTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w900)),
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: [
                            Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 1,
                                          color: appTheme.primaryColor,
                                          offset: const Offset(0, 5))
                                    ],
                                    color: appTheme.darkblue,
                                    borderRadius: BorderRadius.circular(100)),
                                child: profiledataprovider.imageData != null
                                    ? ClipOval(
                                        child: Image.memory(
                                            profiledataprovider.imageData!,
                                            fit: BoxFit.cover))
                                    : Image.asset(
                                        ImgIcons.iconperson,
                                        scale: 4,
                                      )),
                            Positioned(
                              right: 10,
                              bottom: 5,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: appTheme.mainTextColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    if (kIsWeb) {
                                      FilePickerResult? result =
                                          await FilePicker.platform
                                              .pickFiles(type: FileType.image);
                                      if (result != null) {
                                        Uint8List file =
                                            result.files.single.bytes!;
                                        profiledataprovider
                                            .setprofilepicinweb(file);
                                      } else {
                                        // User canceled the picker
                                      }
                                    } else {
                                      bottomsheet(context, profiledataprovider);
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 100),
                        SingleChildScrollView(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: appTheme.black,
                                  borderRadius: BorderRadius.circular(10)),
                              width: 350,
                              child: Form(
                                key: nameKey,
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.always,
                                  controller:
                                      profiledataprovider.nameController,
                                  style:
                                      TextStyle(color: appTheme.mainTextColor),
                                  decoration: InputDecoration(
                                      hintText: 'What Should we call you?',
                                      hintStyle: TextStyle(
                                          color: appTheme.accentColor),
                                      prefixIcon: Icon(
                                        Icons.person_outlined,
                                        color: appTheme.accentColor,
                                      ),
                                      border: InputBorder.none),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ]),
              )),
        ));
  }

  Future<dynamic> bottomsheet(
      BuildContext context, ProfileDataProvider profiledataprovider) {
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
                  const Text(
                    'Choose Profile Photo',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () async {
                            final returnedcamera = await ImagePicker()
                                .pickImage(source: ImageSource.camera);
                            final fileImage = File(returnedcamera!.path);
                            profiledataprovider.setProfilePic(fileImage);
                          },
                          icon: const Icon(Icons.camera),
                          label: const Text('Camera')),
                      ElevatedButton.icon(
                          onPressed: () async {
                            final returnedImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            final fileImage = File(returnedImage!.path);
                            profiledataprovider.setProfilePic(fileImage);
                          },
                          icon: const Icon(Icons.image),
                          label: const Text('Gallery'))
                    ],
                  )
                ],
              ),
            ));
  }
}
