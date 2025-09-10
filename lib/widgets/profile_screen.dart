import 'package:file_picker/file_picker.dart';
import 'package:financify/providers/profile_provider.dart';
import 'package:financify/widgets/bottom_sheet_method.dart';
import 'package:financify/widgets/circle_widget_with_icon.dart';

import 'package:financify/utils/images.dart';
import 'package:financify/theme/themes.dart';
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
                              onPressed: () => _handleNextButton(
                                context,
                                nameController,
                                profileDataProvider,
                              ),
                              child: Text(
                                'NEXT',
                                style: TextStyle(color: appTheme.primaryColor),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                       Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    // --- Title Section ---
    Text(
      'Set up your',
      style: TextStyle(color: appTheme.mainTextColor),
    ),
    const SizedBox(height: 20),
    Text(
      'Profile Picture',
      style: TextStyle(
        color: appTheme.mainTextColor,
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    ),
    const SizedBox(height: 20),

    // --- Profile Picture Section ---
    _ProfilePicturePicker(
      appTheme: appTheme,
      profileDataProvider: profileDataProvider,
    ),
    const SizedBox(height: 100),

    // --- Name Input Section ---
    _NameInputField(
      appTheme: appTheme,
      nameController: nameController,
    ),
  ],
)
                      ]),
                ),
              )),
        ));
  }


  
  // --- Helper function (outside build method, inside your widget class) ---
void _handleNextButton(
  BuildContext context,
  TextEditingController nameController,
  ProfileDataProvider profileDataProvider,
) async {
  final name = nameController.text.trim();
  final hasImage = profileDataProvider.imageData != null;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  if (name.isEmpty && !hasImage) {
    showSnackBar('Please enter your name and select your profile photo');
    return;
  }

  if (name.isEmpty) {
    showSnackBar('Please enter your name');
    return;
  }

  if (!hasImage) {
    showSnackBar('Please select your profile photo');
    return;
  }

  // If valid → proceed
  profileDataProvider.setProfileName(name);
  FocusScope.of(context).unfocus();

  await Future.delayed(const Duration(milliseconds: 200));
  toSelectCurrency(context);
}

}


// --- Profile Picture Picker Widget ---
class _ProfilePicturePicker extends StatelessWidget {
  final AppTheme appTheme;
  final ProfileDataProvider profileDataProvider;

  const _ProfilePicturePicker({
    required this.appTheme,
    required this.profileDataProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleWidgetWithIcon(
          insideIcon: profileDataProvider.imageData != null
              ? ClipOval(
                  child: Image.memory(
                    profileDataProvider.imageData!,
                    fit: BoxFit.cover,
                  ),
                )
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
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                if (kIsWeb) {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );
                  if (result != null) {
                    final Uint8List file = result.files.single.bytes!;
                    profileDataProvider.setprofilepicinweb(file);
                  }
                } else {
                  bottomsheet(appTheme, context, profileDataProvider);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

// --- Name Input Field Widget ---
class _NameInputField extends StatelessWidget {
  final AppTheme appTheme;
  final TextEditingController nameController;

  const _NameInputField({
    required this.appTheme,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          hintText: 'What should we call you?',
          hintStyle: TextStyle(color: appTheme.accentColor),
          prefixIcon: Icon(
            Icons.person_outlined,
            color: appTheme.accentColor,
          ),
        ),
      ),
    );
  }
}
