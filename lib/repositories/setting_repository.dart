import 'dart:convert';

import 'package:flutter_sample/models/setting.dart';
import 'package:hive/hive.dart';

class SettingRepository {
  static register() async {}

  static getSetting() async {
    var box = await Hive.openBox('settings');
    var name = box.get('name', defaultValue: '');

    var fullName = box.get('fullName', defaultValue: '');
    var email = box.get('email', defaultValue: '');
    var token = box.get('token', defaultValue: '');

    Setting setting = new Setting(
      name: name,
    );

    setting.fullName = fullName;
    setting.email = email;
    setting.token = token;

    return setting;
  }

  static updateSetting(Setting setting) async {
    var box = await Hive.openBox('settings');
    box.put('name', setting.name);

    box.put('fullName', setting.fullName);
    box.put('email', setting.email);
    box.put('token', setting.token);
  }
}
