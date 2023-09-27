// drawer_provider.dart
import 'package:flutter/material.dart';

class DrawerProvider with ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
}
