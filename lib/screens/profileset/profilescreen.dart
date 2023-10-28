import 'package:financify/utils/images.dart';
import 'package:financify/utils/themes.dart';
import 'package:flutter/material.dart';

class ProfileSetScreen extends StatelessWidget {
  const ProfileSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Stack(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    await Future.delayed(const Duration(milliseconds: 100));
                    Navigator.pushNamed(context,'CurrencySelect');
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
                        child: Image.asset(
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
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 100),
                SingleChildScrollView(
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.black,
                          borderRadius: BorderRadius.circular(10)),
                      width: 350,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        controller: nameController,
                        style: const TextStyle(color: AppTheme.mainTextColor),
                        decoration: const InputDecoration(
                            hintText: 'What Should we call you?',
                            hintStyle: TextStyle(color: AppTheme.accentColor),
                            prefixIcon: Icon(
                              Icons.person_outlined,
                              color: AppTheme.accentColor,
                            ),
                            border: InputBorder.none),
                      )),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
