import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileSetScreen extends StatelessWidget {
  const ProfileSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    final nameKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: appTheme.backgroundColor,
        body: Consumer<ProfileDataProvider>(
          builder: ((context, profileDataProvider, child) => SafeArea(
                child: Stack(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () async {
                            // ProfileDB().clearProfile();
                            if (nameKey.currentState!.validate() &&
                                profileDataProvider.imageData != null) {
                              profileDataProvider
                                  .setProfileName(nameController.text);
                              // profileDataProvider.profileToBD();
                              FocusScope.of(context).unfocus();
                              await Future.delayed(
                                  const Duration(milliseconds: 200));
                              await Future.delayed(
                                      const Duration(milliseconds: 100))
                                  .then((value) => toSelectCurrency(context));
                            } else {
                              const snackBar = SnackBar(
                                content:
                                    Text('Please Select your Profile Photo'),
                                duration: Duration(
                                    seconds:
                                        3),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Text(
                            'NEXT',
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
                                child: profileDataProvider.imageData != null
                                    ? ClipOval(
                                        child: Image.memory(
                                            profileDataProvider.imageData!,
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
                                        profileDataProvider
                                            .setprofilepicinweb(file);
                                      } else {
                                        // User canceled the picker
                                      }
                                    } else {
                                      bottomsheet(appTheme, context,
                                          profileDataProvider);
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 100),
                        SingleChildScrollView(
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: appTheme.black,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 350,
                                  height: 50,
                                  child: Padding(
                                padding: EdgeInsets.only(
                                    left: 5,),
                                child: Form(
                                  key: nameKey,
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Please Enter your Name';
                                      } else if (!RegExp(r'^[A-Za-z\s\-]+$')
                                          .hasMatch(value)) {
                                        return 'Please Enter Your Correct Name';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: nameController,
                                    style: TextStyle(
                                        color: appTheme.mainTextColor),
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
                                ),
                              ),
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              )),
        ));
  }

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
                    style:
                        TextStyle(fontSize: 20, color: appTheme.mainTextColor),
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
                                    seconds:
                                        3), // Adjust the duration as needed
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
}
