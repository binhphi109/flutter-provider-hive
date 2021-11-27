import 'package:flutter/material.dart';
import 'package:flutter_sample/stores/settings.dart';
import 'package:flutter_sample/widgets/empty_wrapper.dart';
import 'package:flutter_sample/widgets/home_drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  @override
  initState() {
    super.initState();

    context.read<Settings>().loadSettings();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: HomeDrawer(),
      body: Center(
        child: Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
