import 'package:flutter/material.dart';

// 使用する色を先に定義
const Color kAccentColor = Color(0xFFFE7C64);
const Color kBackgroundColor = Color(0xFF19283D);
const Color kTextColorPrimary = Color(0xFFECEFF1);
const Color kTextColorSecondary = Color(0xFFB0BEC5);
const Color kButtonColorPrimary = Color(0xFFECEFF1);
const Color kButtonTextColorPrimary = Color(0xFF455A64);
const Color kIconColor = Color(0xFF455A64);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // プロパティをカスタマイズするためにcopywithを使用
      theme: ThemeData.dark().copyWith(
        // アプリのアクセントカラー
        accentColor: kAccentColor,
      ),
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      // safeareaはOSにかかわらず画面の範囲内に適切にウィジェットを収めてくれる
      body: SafeArea(
        // SingleChildScrollView: リスト形式ではないが、画面全体をスクロールできるようにする
        child: SingleChildScrollView(
          child: Column(
            children[],
          ),
        ),
      ),
    );
  }
}
