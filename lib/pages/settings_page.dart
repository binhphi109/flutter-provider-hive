import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sample/helpers/dialogs.dart';
import 'package:flutter_sample/helpers/field_errors.dart';
import 'package:flutter_sample/helpers/toast.dart';
import 'package:flutter_sample/models/setting.dart';
import 'package:flutter_sample/stores/errors.dart';
import 'package:flutter_sample/stores/settings.dart';
import 'package:flutter_sample/widgets/buttons.dart';
import 'package:flutter_sample/widgets/error_list.dart';
import 'package:flutter_sample/widgets/home_drawer.dart';
import 'package:flutter_sample/widgets/outline_input.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
  TextEditingController tfName = TextEditingController();

  late TabController tabController = TabController(vsync: this, length: 2);
  int currentTabIndex = 0;

  List<FieldError> errors = [];
  Setting setting = new Setting(name: '');

  var privateKey;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    init();
  }

  @override
  void dispose() {
    tfName.dispose();
    tabController.dispose();
    super.dispose();
  }

  init() async {
    setting = await context.read<Settings>().loadSettings();
    context.read<Errors>().loadErrors();

    tabController.addListener(handleTabSelection);
    setState(() {
      tfName.text = setting.name;
    });
  }

  validate(String name) {
    errors.clear();

    if (name.isEmpty) {
      errors.add(new FieldError(field: 'name', message: 'Name is missing.'));
    }

    this.setState(() {});

    return errors.length == 0;
  }

  handleSave() async {
    var name = tfName.text;

    var isValid = validate(name);
    if (isValid) {
      setting.name = name.trim();

      await context.read<Settings>().updateSetting(setting);
      setState(() {});

      showToastSuccess("Updated Setting successfully");
    }
  }

  handleClearAllErrors() async {
    await showConfirmDialog(
      context,
      content: 'Are you sure to clear all errors?',
      onConfirm: () async {
        await context.read<Errors>().clearAllErrors();

        showToastSuccess('Cleared all errors successfully');
      },
    );
  }

  handleLogin() {
    var settings = context.read<Settings>().settings;
    if (settings.token.isEmpty) {
      Navigator.pushNamed(context, "/login");
    } else {
      context.read<Settings>().clearAuth();
    }
  }

  handleTabSelection() {
    setState(() {
      currentTabIndex = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: tabController,
          indicatorWeight: 4,
          tabs: [
            Tab(child: Text('General')),
            Tab(child: Text('Errors')),
          ],
        ),
        title: Text('Settings'),
        actions: currentTabIndex == 0
            ? [
                IconButton(
                  onPressed: handleSave,
                  icon: Icon(Icons.save),
                ),
              ]
            : [
                IconButton(
                  onPressed: () {
                    handleClearAllErrors();
                  },
                  icon: Icon(CupertinoIcons.trash),
                ),
              ],
      ),
      drawer: HomeDrawer(),
      body: TabBarView(
        controller: tabController,
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Consumer<Settings>(
                    builder: (_, model, __) {
                      return Column(children: [
                        model.settings.token.isNotEmpty
                            ? Column(children: [
                                ListTile(
                                  leading: InkWell(
                                    onDoubleTap: () {},
                                    child: Icon(
                                      FontAwesomeIcons.userCircle,
                                      size: 40,
                                    ),
                                  ),
                                  title: Text(model.settings.fullName),
                                  subtitle: Text(model.settings.email),
                                ),
                                SizedBox(height: 8),
                              ])
                            : Container(),
                        Button(
                          title: model.settings.token.isNotEmpty ? 'Logout' : 'Login',
                          action: () {
                            handleLogin();
                          },
                        )
                      ]);
                    },
                  ),
                  SizedBox(height: 24),
                  OutlineInput(
                    controller: tfName,
                    keyboardType: TextInputType.text,
                    hintText: 'Name',
                    errorText: getFirstError(errors, 'name')?.message,
                  ),
                ],
              ),
            ),
          ),
          ErrorList(),
        ],
      ),
    );
  }
}
