import 'package:financify/model/category/profilecategory/profile_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

const profileDBName = 'profile_database';
const profileKey = 'profile_key';

abstract class ProfileDBFunctions {
  Future<void> insertProfile(ProfileModel value);
  Future<ProfileModel?> getProfile();
  Future<void> clearProfile();
}

class ProfileDB implements ProfileDBFunctions {
  @override
  Future<void> insertProfile(ProfileModel value) async {
    final profileDB = await Hive.openBox<ProfileModel>(profileDBName);
      await profileDB.put(profileKey,value);
  }

  @override
  Future<ProfileModel?> getProfile() async {
    final profileDB = await Hive.openBox<ProfileModel>(profileDBName);
    return profileDB.get(profileKey);
  }

  @override
  Future<void> clearProfile() async {
    final profileDB = await Hive.openBox<ProfileModel>(profileDBName);
    await profileDB.clear();
  }
}


