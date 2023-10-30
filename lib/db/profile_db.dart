import 'package:financify/model/category/profilecategory/profile_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

const PROFILE_DB_NAME = 'category_database';
const PROFILE_KEY = 'profile_key';

abstract class ProfileDBFunctions {
  Future<void> insertProfile(ProfileModel value);
  Future<ProfileModel?> getProfile();
  Future<void> clearProfile();
}

class ProfileDB implements ProfileDBFunctions {
  @override
  Future<void> insertProfile(ProfileModel value) async {
    final profileDB = await Hive.openBox<ProfileModel>(PROFILE_DB_NAME);
      await profileDB.put(PROFILE_KEY,value);
  }

  @override
  Future<ProfileModel?> getProfile() async {
    final profileDB = await Hive.openBox<ProfileModel>(PROFILE_DB_NAME);
    return profileDB.get(PROFILE_KEY);
  }

  @override
  Future<void> clearProfile() async {
    final profileDB = await Hive.openBox<ProfileModel>(PROFILE_DB_NAME);
    profileDB.clear();
  }
}


