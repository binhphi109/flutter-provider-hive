import 'package:flutter/material.dart';
import 'package:flutter_sample/stores/settings.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  bool showActivity = false;

  @override
  void initState() {
    super.initState();
    initPackageInfo();
  }

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  handleToggleActivity() {
    setState(() {
      showActivity = !showActivity;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showActivity = !showActivity;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(builder: (_, model, __) {
      return Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 140,
              child: DrawerHeader(
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/logoText.png",
                      width: 120,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: Text("Sell"),
                    leading: Icon(Icons.receipt_long), //Icon(Icons.shopping_cart),
                    onTap: () {
                      Navigator.pushNamed(context, "/home");
                    },
                  ),
                  ListTile(
                    title: Text("Catalog"),
                    leading: Icon(Icons.web),
                    onTap: () {
                      Navigator.pushNamed(context, "/catalog");
                    },
                  ),
                  ListTile(
                    title: Text("Activity"),
                    leading: Icon(Icons.trending_up),
                    onTap: () {
                      Navigator.pushNamed(context, "/checkpin");
                    },
                  ),
                  ListTile(
                    title: Text("Settings"),
                    leading: Icon(Icons.settings),
                    onTap: () {
                      Navigator.pushNamed(context, "/settings");
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  children: <Widget>[
                    Divider(),
                    ListTile(
                      leading: ClipOval(
                        child: InkWell(
                          onDoubleTap: () {
                            handleToggleActivity();
                          },
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 40,
                            width: 40,
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      title: Text('Version'),
                      // trailing: Text(subtitle.isEmpty ? 'Not set' : subtitle),
                      subtitle: Text(_packageInfo.version),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
