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
      // デバッグ表示を削除
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
            children: [
              // ここにコンポーネントを置いていく
              _Header(),
            ],
          ),
        ),
      ),
    );
  }
}

// 背景のクリップ。曲線を使う
class _HeaderCurveClipper extends CustomClipper<Path> {
  @override
  // getClip: クリップのサイズと位置を定義
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height * 0.5)
      // ベジエ曲線
      ..quadraticBezierTo(
        size.width * 0.55,
        size.height,
        size.width,
        size.height * 0.6,
      )
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  // 前のクリップを使いたい時に使用
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _HeaderBackground extends StatelessWidget {
  final double height;

  // ???
  const _HeaderBackground({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      // clipperで使うクリップを指定
      clipper: _HeaderCurveClipper(),
      child: Container(
        // 横幅いっぱいに広げる
        width: double.infinity,
        // 高さはそのまま???
        height: height,
        // 装飾
        decoration: BoxDecoration(
          // グラデーション
          gradient: LinearGradient(
            // ラインでグラデーションを引くために、開始と終了の位置を定義
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            colors: [
              Color(0xFFFD9766),
              Color(0xFFFF7362),
            ],
            // ???
            stops: [0, 1],
          ),
        ),
      ),
    );
  }
}

// 2つの丸の描画を定義
class _HeaderCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // ペイントの定義
    final paint = Paint()
      // 丸の色
      ..color = Colors.white.withOpacity(0.4)
      // 丸のスタイル
      ..style = PaintingStyle.stroke
      // 丸の太さ
      ..strokeWidth = 6;

    // 実際に描画
    canvas.drawCircle(
      // 位置、大きさ、オブジェクト
      Offset(size.width * 0.20, size.height * 0.4),
      12,
      paint,
    );
    // 実際に描画
    canvas.drawCircle(
      // 位置、大きさ、オブジェクト
      Offset(size.width * 0.75, size.height * 0.2),
      12,
      paint,
    );
  }

  // 再描画が必要かどうかを返す。一度描画したら状態が変わらないものを描画する場合は、再描画する必要がないので、常にfalseを返す。
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _HeaderCircles extends StatelessWidget {
  final double height;

  const _HeaderCircles({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HeaderCirclePainter(),
      child: Container(
        width: double.infinity,
        height: height,
      ),
    );
  }
}

// タイトルのウィジェット
class _HeaderTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      // columnはデフォルトで最大のたかさまで広がってしまうので、MainAxisSizeで調整
      mainAxisSize: MainAxisSize.min,
      children: [
        // 余白
        SizedBox(height: 10),
        Text(
          'Welcome',
          style: Theme.of(context).textTheme.headline4.copyWith(
                color: kTextColorPrimary,
                fontWeight: FontWeight.w500,
              ),
        ),
        // 余白
        SizedBox(height: 4),
        Text(
          'Sign in to continue',
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(color: kTextColorPrimary),
        ),
      ],
    );
  }
}

// 左上の戻るボタンのウィジェット
class _HeaderBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.transparent,
      shape: CircleBorder(
        side: BorderSide(color: Colors.white),
      ),
      // 押された時の動き。今回は空
      onPressed: () {},
      child: Icon(Icons.chevron_left, color: kIconColor),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = 320;
    return Container(
      height: height,
      // Stack: 複数のウィジェットを重ねて表示したいときに利用
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: _HeaderBackground(height: height),
          ),
          // 丸2つのウィジェット
          Align(
            alignment: Alignment.topCenter,
            child: _HeaderCircles(height: height),
          ),
          // welcome~の文章のウィジェット
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 128),
              child: _HeaderTitle(),
            ),
          ),
          // 左上の戻るボタンのウィジェット
          Positioned(
            top: 16,
            left: 0,
            child: _HeaderBackButton(),
          ),
        ],
      ),
    );
  }
}
