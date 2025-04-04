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
  static var _checkMessage = "Please Select.";
  // チェックボックスの状態を保持する変数。初期値は未チェックとする
  static var _checked = false;
  // ラジオボタンの状態を保持する変数
  static var _radioSelected = 'A';
  // ラジオボタンのメッセージの変数
  static var _radioMessage = "選択してください";
  // ドロップダウンボタンの状態を保持する変数
  static var _dropdownSelected = "A";
  // ドロップダウンボタンのメッセージを保持する変数
  static var _dropdownMessage = "Please Select.";
  // スライダーのメッセージを保持する変数
  static var _sliderMessage = "値を設定しましょう";
  // スライダーの値を保持する変数
  static var _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App Name")), // 上部のアプリバー（タイトル表示）
      body: SingleChildScrollView(
        // ← スクロール可能にする
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
                _checkMessage,
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
                  ),
                ],
              ),
            ),
            // ラジオボタンメッセージ部分
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                _radioMessage,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                ),
              ),
            ),
            // ラジオボタン追加部分
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Radio<String>(
                    value: 'A',
                    groupValue: _radioSelected,
                    onChanged: radioChanged,
                  ),
                  Text(
                    "radio A",
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Radio<String>(
                    value: 'B',
                    groupValue: _radioSelected,
                    onChanged: radioChanged,
                  ),
                  Text(
                    "radio B",
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                    ),
                  ),
                ],
              ),
            ),
            // ドロップダウンボタン追加部分
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      _dropdownMessage,
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    onChanged: popupSelected,
                    value: _dropdownSelected, // 修正: 'A' を含む選択肢を追加
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                    ),
                    items: const <DropdownMenuItem<String>>[
                      DropdownMenuItem<String>(value: "A", child: Text("A")),
                      DropdownMenuItem<String>(value: "B", child: Text("B")),
                      DropdownMenuItem<String>(value: "C", child: Text("C")),
                    ],
                  ),
                ],
              ),
            ),
            // ポップアップメニューボタン追加部分
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      _dropdownMessage,
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight, // 右寄せに配置
                    child: PopupMenuButton<String>(
                      onSelected: popupSelected, // 選択時の処理
                      itemBuilder:
                          (BuildContext context) => <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: "One",
                              child: Text("One"),
                            ),
                            const PopupMenuItem<String>(
                              value: "Two",
                              child: Text("Two"),
                            ),
                            const PopupMenuItem<String>(
                              value: "Three",
                              child: Text("Three"),
                            ),
                          ],
                    ),
                  ),
                ],
              ),
            ),
            // スライダー追加部分
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // スライダーのメッセージ部分
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      _sliderMessage,
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                  // スライダー本体
                  Slider(
                    onChanged: sliderChanged,
                    min: 0.0,
                    max: 100.0,
                    divisions: 20,
                    value: _sliderValue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkChanged(bool? value) {
    setState(() {
      _checked = value!;
      _checkMessage = value ? "checked!" : "not checked…";
    });
  }

  void radioChanged(String? value) {
    setState(() {
      _radioSelected = value!;
      _radioMessage = '$_radioSelectedを選択';
    });
  }

  void popupSelected(String? value) {
    setState(() {
      _dropdownSelected = value ?? "not selected...";
      _dropdownMessage = 'your select is $_dropdownSelected';
    });
  }

  void sliderChanged(double value) {
    setState(() {
      _sliderValue = value.floorToDouble();
      _sliderMessage = '設定した値: $_sliderValue';
    });
  }
}
