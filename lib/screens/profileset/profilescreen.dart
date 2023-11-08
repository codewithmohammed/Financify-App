import 'dart:io';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileSetScreen extends StatelessWidget {
  const ProfileSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: Consumer<ProfileDataProvider>(
          builder: ((context, ProfileDataProvider, child) => SafeArea(
                child: Stack(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () async {
                            // ProfileDB().clearProfile();
                            if (nameKey.currentState!.validate() &&
                                ProfileDataProvider.imageData != null) {
                              ProfileDataProvider.setProfileName(
                                  nameController.text.toString());
                              ProfileDataProvider.profileToBD();
                              FocusScope.of(context).unfocus();
                              await Future.delayed(
                                  const Duration(milliseconds: 200));
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'CurrencySelect', (route) => false);
                            } else {
                              return;
                            }
                          },
                          child: const Text(
                            'NEXT',
                            style: TextStyle(color: AppTheme.primaryColor),
                            textAlign: TextAlign.right,
                          )),
                    ],
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Set up your',
                            style: TextStyle(color: AppTheme.mainTextColor)),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Profile Picture',
                            style: TextStyle(
                                color: AppTheme.mainTextColor,
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
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 1,
                                          color: AppTheme.primaryColor,
                                          offset: Offset(0, 5))
                                    ],
                                    color: AppTheme.darkblue,
                                    borderRadius: BorderRadius.circular(100)),
                                child: ProfileDataProvider.imageData != null
                                    ? ClipOval(
                                        child: Image.file(
                                            ProfileDataProvider.imageData!,
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
                                    color: AppTheme.mainTextColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (builder) => Container(
                                              height: 100,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 20,
                                              ),
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    'Choose Profile Photo',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ElevatedButton.icon(
                                                          onPressed: () async {
                                                            final returnedcamera =
                                                                await ImagePicker()
                                                                    .pickImage(
                                                                        source:
                                                                            ImageSource.camera);
                                                            final fileImage = File(
                                                                returnedcamera!
                                                                    .path);
                                                            ProfileDataProvider
                                                                .setProfilePic(
                                                                    fileImage);
                                                          },
                                                          icon: const Icon(
                                                              Icons.camera),
                                                          label: const Text(
                                                              'Camera')),
                                                      ElevatedButton.icon(
                                                          onPressed: () async {
                                                            final returnedImage =
                                                                await ImagePicker()
                                                                    .pickImage(
                                                                        source:
                                                                            ImageSource.gallery);
                                                            final fileImage =
                                                                File(
                                                                    returnedImage!
                                                                        .path);
                                                            ProfileDataProvider
                                                                .setProfilePic(
                                                                    fileImage);
                                                          },
                                                          icon: const Icon(
                                                              Icons.image),
                                                          label: const Text(
                                                              'Gallery'))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ));
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
                                      color: AppTheme.black,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 350,
                                  height: 50,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
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
                                    style: const TextStyle(
                                        color: AppTheme.mainTextColor),
                                    decoration: const InputDecoration(
                                        hintText: 'What Should we call you?',
                                        hintStyle: TextStyle(
                                            color: AppTheme.accentColor),
                                        prefixIcon: Icon(
                                          Icons.person_outlined,
                                          color: AppTheme.accentColor,
                                        ),
                                        border: InputBorder.none),
                                  ),
                                ),
                              )
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
}
