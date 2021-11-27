import 'package:flutter/material.dart';
import 'package:flutter_sample/models/setting.dart';
import 'package:flutter_sample/repositories/setting_repository.dart';

class Settings with ChangeNotifier {
  Setting settings = new Setting(name: '');
  bool isLicenseWarningConfirmed = false;

  Future<Setting> loadSettings() async {
    this.settings = await SettingRepository.getSetting();
    notifyListeners();

    return this.settings;
  }

  updateAuth(String token, String name, String email) async {
    this.settings.fullName = name;
    this.settings.email = email;
    this.settings.token = token;

    await SettingRepository.updateSetting(this.settings);

    notifyListeners();
  }

  clearAuth() async {
    this.settings.fullName = '';
    this.settings.email = '';
    this.settings.token = '';

    await SettingRepository.updateSetting(this.settings);

    notifyListeners();
  }

  updateSetting(Setting setting) async {
    await SettingRepository.updateSetting(setting);
    this.settings = setting;

    notifyListeners();
  }
}
