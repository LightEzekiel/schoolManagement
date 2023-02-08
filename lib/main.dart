import 'dart:io' show Platform;
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phrankstar/models/basic_school_class_staff.dart';
import 'package:phrankstar/models/high_school_class_staff.dart';
import 'package:phrankstar/workArea/basic_school_user.dart';
import 'package:phrankstar/workArea/basic_user.dart';
import 'package:phrankstar/workArea/update_basic_staff.dart';
import 'package:phrankstar/workArea/update_basic_user.dart';
import 'package:phrankstar/workArea2/add_high_staff.dart';
import 'package:phrankstar/workArea2/high.dart';
import 'package:phrankstar/workArea2/high_school_staff.dart';

import 'package:phrankstar/authentications/basic_login.dart';
import 'package:phrankstar/authentications/high_school_login.dart';
import 'package:phrankstar/constants.dart';
import 'package:phrankstar/providers/auth.dart';
import 'package:phrankstar/workArea/add_basic_staff.dart';
import 'package:phrankstar/workArea/basic.dart';
import 'package:phrankstar/workArea/basic_school_staff.dart';
import 'package:phrankstar/workArea2/high_school_user.dart';
import 'package:phrankstar/workArea2/high_user.dart';
import 'package:phrankstar/workArea2/update_high_school_user.dart';
import 'package:phrankstar/workArea2/update_high_staff.dart';
import 'package:window_manager/window_manager.dart';
import './choose_option.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    doWhenWindowReady(() {
      final initialSize = Size(800, 800);
      // final minSize = Size(800, 700);

      // appWindow.size = initialSize;
      appWindow.minSize = initialSize;
      final maxSize = Size(
          WidgetsBinding.instance.window.physicalSize.height * 100,
          WidgetsBinding.instance.window.physicalSize.width * 100);
      appWindow.maxSize = maxSize;

      // appWindow.minSize = minSize;
      // appWindow.size = initialSize; //default size
      appWindow.show();
    });
  }

  // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
  //   // setWindowTitle('My App');
  //   setWindowMinSize(Size(512, 384));
  //   // DesktopWindow.setWindowMinSize(Size(min_width, min_height));

  //   // DesktopWindow.setMinWindowSize(Size(300, 400));
  //   // 1280, 720
  // }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, PCAS>(
          create: (_) => PCAS(),
          update: (ctx, auth, previousProduct) =>
              previousProduct!..update(auth.token, auth.userId),
          //  Products(auth.token!,
          //     previousProduct!.item.isEmpty ? [] : previousProduct.item),
        ),
        ChangeNotifierProvider.value(
          value: PCAS(),
        ),
        ChangeNotifierProvider.value(
          value: PHSS(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: null, primaryColor: oxblood),
        home: ChooseOption(),
        // BasicStaff()

        routes: {
          BasicLogin.routeName: (ctx) => BasicLogin(),
          AddBasicStaff.routeName: (ctx) => AddBasicStaff(),
          BasicSchoolProfileAdmin.routeName: (ctx) => BasicSchoolProfileAdmin(),
          UserProfileBasicShool.routeName: (ctx) => UserProfileBasicShool(),
          BasicSchoolStaffAdmin.routeName: (ctx) => BasicSchoolStaffAdmin(),
          BasicSchoolUser.routeName: (ctx) => BasicSchoolUser(),
          UpdateBasicStaff.routeName: (ctx) => UpdateBasicStaff(),
          UpdateBasicUser.routeName: (ctx) => UpdateBasicUser(),
          HighSchoolLogin.routeName: (ctx) => HighSchoolLogin(),
          HighSchoolStaffAdmin.routeName: (ctx) => HighSchoolStaffAdmin(),
          HighSchoolStaffProfileAdmin.routeName: (ctx) =>
              HighSchoolStaffProfileAdmin(),
          HighSchoolUser.routeName: (ctx) => HighSchoolUser(),
          UpdateHighSchoolStaff.routeName: (ctx) => UpdateHighSchoolStaff(),
          UpdateHighSchoolUser.routeName: (ctx) => UpdateHighSchoolUser(),
          AddHighSchoolStaff.routeName: (ctx) => AddHighSchoolStaff(),
          UserHighSchoolProfile.routeName: (ctx) => UserHighSchoolProfile(),
        },
      ),
    );
  }
}
