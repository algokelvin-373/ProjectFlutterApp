import 'package:flutter/material.dart';
import 'package:ui_dynamicitem/widget/dynamic_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Training',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePageState(title: 'Flutter Training - Dynamic Item'),
    );
  }
}

class HomePageState extends StatefulWidget {
  const HomePageState({super.key, required this.title});

  final String title;

  @override
  State<HomePageState> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageState> {
  final items = <ListItem>[
    HeadingItem('Today'),
    MessageItem('Alice', 'Hey! How are you?'),
    MessageItem('Bob', 'Flutter is awesome!'),
    HeadingItem('Yesterday'),
    MessageItem('Charlie', 'See you later!'),
  ];

  AppBar _header() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
    );
  }

  Widget _mainPage(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _header(), body: _mainPage(context));
  }
}
