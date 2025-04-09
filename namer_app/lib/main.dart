import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:namer_app/favorites_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

//3-1. アプリ全体の状態を作成し、アプリに名前を付け、視覚的テーマを設定し、アプリの出発点となる「ホーム」ウィジェットを設定
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // 状態は ChangeNotifierProvider を使用して作成されてアプリ全体に提供
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// 7-2.  変更の主なポイント：NavigationRail の追加とページの分割設計の準備
//Scaffold 内部のレイアウトが Row ベースになった（画面を左右に分けるため）
//NavigationRail を追加してナビゲーションのUIを表示
//今は選択状態が固定（selectedIndex: 0）だが、後で状態管理で切り替える準備ができている

// 4-2. MyAppState クラスでアプリの状態を定義
// MyAppState では、アプリが機能するために必要となるデータを定義
class MyAppState extends ChangeNotifier {
  // 状態クラスは ChangeNotifier を拡張
  var current = WordPair.random();

  // 4. getNextメソッドを追加
  void getNext() {
    // getNext() メソッドは、current に新しいランダムな WordPair を再代入
    current = WordPair.random();
    notifyListeners(); // notifyListeners()（ChangeNotifier) のメソッド）の呼び出し
  }

// 6-1. お気に入りボタンの追加
  var favorites = <WordPair>[];
  void toggleFavorite() {
    // このメソッドは、お気に入りのリストから現在の単語ペアを取り除くか（すでにそこにある場合）、追加
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners(); // その後でこのコードから notifyListeners();が呼び出される
  } // お気に入りボタンの追加ここまで
}

// 7-1. MyHomePageを2つのウィジェットに分割

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0; // 7-3. 追加

  @override
  Widget build(BuildContext context) {
    // 7-4. 表示スクリーンの決定
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritePage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, Constraints) {
      return Scaffold(
        // ★ ScaffoldのbodyがColumn → Rowに変更された
        // 画面を縦にではなく横に2分割（ナビゲーション + メイン表示）するため
        body: Row(
          children: [
            SafeArea(
              // ★ NavigationRail を追加：左端に表示される縦型のナビゲーションUI
              // 選択肢を2つ表示（Home / お気に入り）今後切り替えを実装予定
              child: NavigationRail(
                extended: Constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('お気に入り'),
                  ),
                ],
                // ★ 現時点では「常にHomeが選ばれている状態」に固定
                // 今後「selectedIndex」を状態で切り替えられるようにする必要あり
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            // ★ Expandedで右側のメイン表示領域を確保
            // 画面幅いっぱいに GeneratorPage を表示
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page, // ここでページを切り替え
              ),
            ),
          ],
        ),
      );
    });
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 周囲の状況が変化するたびに自動的に呼び出される build() メソッドを定義
    var appState = context.watch<MyAppState>();
    var pair = appState.current; // 5-1. UI の独立した論理部品を独立したウィジェットにする
    // 「本当に必要なのは現在の単語ペアが何であるか」

    // 6-2. お気に入りアイコンの定義
    // 「今表示している単語（＝pair）が、お気に入りリスト（favorites）に入っているかどうかを調べて、入っていたら 塗りつぶし、入っていなければ 線だけのアイコンを表示する」。→ 初見の単語は入っていないため、favorite_borderになる
    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite; // ❤️ お気に入り済み
    } else {
      icon = Icons.favorite_border; // 🤍 まだお気に入りじゃない
    }

    return Center(
      // 5-8. 中央揃え（横方向）
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 5-8. 中央揃え（縦方向）
        children: [
          // Text('A random Awesome idea:'), // 5-9. 余計なテキストウィジェットは削除
          BigCard(pair: pair), // 5-2. 大きい文字をリファクタでBigCardに変更。コード末尾にクラスが新たに作られる
          SizedBox(height: 40), // 5-9. スペーサー代わりのSizedBox
          // 4. ボタンを追加してみる
          Row(
            mainAxisSize: MainAxisSize.min, // 6-2. Row に対して水平方向のスペースをすべて埋めない
            children: [
              // 6-1. お気に入りボタンの作成。ElevatedButton.icon() コンストラクタを使用
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                // 6-2. ElevatedButton.icon() は、アイコンとテキストの両方を扱う特別なコンストラクタなので、child: ではなく、icon: と label: という2つの引数を取る
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 40),
              ElevatedButton(
                onPressed: () {
                  // 4-2. ボタンを押すとvscodeのコンソールに「button pressed!」と出る
                  // print('button pressed!'); // 確認が済んだら用済み

                  // 4-2.ボタンのコールバックからgetNextを呼び出すようにする
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // 5-5. Theme.of(context) でアプリの現在のテーマをリクエスト
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme
          .onPrimary, // onPrimary プロパティには、アプリのプライマリ カラーに使用するのに適した色が定義
    ); // 5-6.アプリのフォントテーマにアクセスし、色や大きさを変更

    return Card(
      // 5-4. PaddingをWidgetでwrap。widgetをCardと入力。→Padding ウィジェットが、そして必然的に Text も、Card ウィジェットに包まれます
      color: theme.colorScheme
          .primary, // 5-5. カードの色をテーマの colorScheme プロパティと同じになるよう定義。これで、アプリのプライマリーカラーによって塗りつぶされる。
      elevation: 6.0, // 5-6.（自分でテスト追加）カード影の調整
      child: Padding(
        // TextをPaddingでwrap
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          // 5-7. 文字列補間を使用して、pair に含まれている 2 つの単語から "cheap head" などの文字列を作成する"${pair.first} ${pair.second}" を追加
          semanticsLabel: "${pair.first} ${pair.second}",
        ), // 5-6.上で定義したstyleを呼び出す。適用。
      ),
    );
  }
}
