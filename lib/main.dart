import 'package:flutter/material.dart';
import 'package:apl_manajemen_kesehatan/helpers/user_info.dart';
import 'package:apl_manajemen_kesehatan/ui/login_page.dart';
import 'package:apl_manajemen_kesehatan/ui/aktivitas_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    setState(() {
      page = token != null ? const CatatanAktivitasFisikPage() : const LoginPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Manajemen Kesehatan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Calibri', // Mengatur font global ke Calibri
      ),
      home: page,
    );
  }
}
