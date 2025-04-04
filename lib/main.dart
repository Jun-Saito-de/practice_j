import 'package:flutter/material.dart';

// アプリのエントリーポイント（ここから実行が始まる）
void main() {
  runApp(const MaterialSampleApp());
}

// アプリ全体の設定をするウィジェット（テーマやホーム画面など）
class MaterialSampleApp extends StatelessWidget {
  const MaterialSampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo", // アプリのタイトル
      theme: ThemeData(
        // アプリ全体のテーマ（色など）を設定
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, //material3 デザインを使うという設定
      ),
      home: const MyHomePage(), // 最初に表示する画面（MyHomePage）
    );
  }
}

// ホーム画面を定義するためのStatefulWidget（状態を持てる）
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// ホーム画面の状態を管理するクラス
class _MyHomePageState extends State<MyHomePage> {
  // 表示メッセージを保持する変数
  static var _message = "ok.";
  // チェックボックスの状態を保持する変数。初期値は未チェックとする
  static var _checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App Name")), // 上部のアプリバー（タイトル表示）
      body: Center(
        child: Column(
          // ここから子ウィジェットを縦方向に並べる（Column）
          mainAxisAlignment: MainAxisAlignment.start, // 上から並べる
          mainAxisSize: MainAxisSize.max, // 可能な限り縦に並べる
          crossAxisAlignment: CrossAxisAlignment.stretch, // 横幅を最大に広げる
          children: <Widget>[
            //　以下、メッセージ表示用のテキスト
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                _message,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                ),
              ),
            ),
             // チェックボックスとテキストを横並びで表示する行
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                   // チェックボックス（状態は _checked によって制御される）
                  Checkbox(value: _checked, onChanged: checkChanged),
                   // チェックボックス横のテキスト
                  Text(
                    "Checkbox",
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                    ),
                  )
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  // チェックボックスが切り替えられたときに呼ばれる関数
  void checkChanged(bool? value){
    setState(() {
      _checked = value!; // nullでないことを確認しつつ、_checkedを 更新する
      _message = value ? "checked!" : "not checked…"; // チェック状態に応じてメッセージを更新する
    });
  }
}
