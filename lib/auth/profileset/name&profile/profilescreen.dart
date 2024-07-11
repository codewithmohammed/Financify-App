import 'package:file_picker/file_picker.dart';
import 'package:financify/auth/profileset/name&profile/widgets/bottom_sheet_method.dart';
import 'package:financify/auth/profileset/name&profile/widgets/circle_widget_with_icon.dart';
import 'package:financify/providers/profile_notifiers.dart';
import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSetScreen extends StatelessWidget {
  const ProfileSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context, listen: true);
    TextEditingController nameController = TextEditingController();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: appTheme.backgroundColor,
        body: Consumer<ProfileDataProvider>(
          builder: ((context, profileDataProvider, child) => SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  if (nameController.text.isNotEmpty &&
                                      profileDataProvider.imageData != null) {
                                    profileDataProvider
                                        .setProfileName(nameController.text);

                                    FocusScope.of(context).unfocus();
                                    await Future.delayed(
                                            const Duration(milliseconds: 200))
                                        .then((value) =>
                                            toSelectCurrency(context));
                                  } else if (nameController.text.isEmpty &&
                                      profileDataProvider.imageData == null) {
                                    const snackBar = SnackBar(
                                      content: Text(
                                          'Please Enter your Name and Select your Profile Photo'),
                                      duration: Duration(seconds: 3),
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (nameController.text.isEmpty &&
                                      profileDataProvider.imageData != null) {
                                    const snackBar = SnackBar(
                                      content: Text('Please Enter your Name '),
                                      duration: Duration(seconds: 3),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    const snackBar = SnackBar(
                                      content: Text(
                                          'Please Select your Profile Photo'),
                                      duration: Duration(seconds: 3),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                child: Text(
                                  'NEXT',
                                  style:
                                      TextStyle(color: appTheme.primaryColor),
                                  textAlign: TextAlign.right,
                                )),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Set up your',
                                style:
                                    TextStyle(color: appTheme.mainTextColor)),
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
                                CircleWidgetWithIcon(
                                  insideIcon: profileDataProvider.imageData !=
                                          null
                                      ? ClipOval(
                                          child: Image.memory(
                                              profileDataProvider.imageData!,
                                              fit: BoxFit.cover))
                                      : Image.asset(
                                          ImgIcons.iconperson,
                                          scale: 4,
                                        ),
                                ),
                                Positioned(
                                  right: 10,
                                  bottom: 5,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: appTheme.mainTextColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () async {
                                        if (kIsWeb) {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles(
                                                      type: FileType.image);
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
                            const SizedBox(
                              height: 100,
                            ),
                            Container(
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: appTheme.darkblue,
                              ),
                              child: TextFormField(
                                controller: nameController,
                                style: TextStyle(color: appTheme.mainTextColor),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  hintText: 'What Should we call you?',
                                  hintStyle:
                                      TextStyle(color: appTheme.accentColor),
                                  prefixIcon: Icon(
                                    Icons.person_outlined,
                                    color: appTheme.accentColor,
                                  ),
                                ),
                              ),
                            ),
                            // const Spacer(),
                          ],
                        ),
                      ]),
                ),
              )),
        ));
  }
}
