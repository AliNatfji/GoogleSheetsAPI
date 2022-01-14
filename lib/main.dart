import 'package:flutter/material.dart';
import 'package:google_sheets/user_sheet_api.dart';

import 'create_sheets_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Google Sheets API';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: CreateSheetsPage(),
    );
  }
}
