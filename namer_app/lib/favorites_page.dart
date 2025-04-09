import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MyAppStateからお気に入りリストを取得
    final favorites = context.watch<MyAppState>().favorites;
    // リストが空の場合の処理（例：お気に入りがない場合）
    if (favorites.isEmpty) {
      return Center(child: Text('お気に入りはまだありません'));
    }
    return Scaffold(
      body: ListView(
        //ListView.builderから変更（テキストをいれるため）
        // ListView の上部にテキストを追加するには、ListView.builder ではなく ListView（固定リスト） を使うのが簡単で自然
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'お気に入り：${favorites.length}件',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          for (var pair in favorites)
            ListTile(
              title: Text(pair.asLowerCase), //favorites[index] と書く必要がない
              leading: Icon(Icons.favorite),
            ),
        ],
      ),
    );
  }
}
