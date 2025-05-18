import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Training',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
        ),
        useMaterial3: true,
      ),
      home: const MainPageState(
        title: 'Flutter Training - ListView',
      ),
    );
  }
}

class MainPageState extends StatefulWidget {
  const MainPageState({super.key, required this.title});

  final String title;

  @override
  State<MainPageState> createState() => _MainPageState();
}

class _MainPageState extends State<MainPageState> {
  bool isVertical = true;

  // Generate 20 Items
  final List<Map<String, dynamic>> items = List.generate(
    20,
    (index) => {
      'icon': Icons.star,
      'label': 'Item ${index + 1}',
    },
  );

  Widget _listViewVerticalWidget() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: Icon(item['icon']),
          title: Text(item['label']),
        );
      },
    );
  }

  Widget _listViewHorizontalWidget() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          width: 120,
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item['icon'], size: 40),
              const SizedBox(height: 8),
              Text(item['label']),
            ],
          ),
        );
      },
    );
  }

  Widget _mainPageWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isVertical = true;
                  });
                },
                child: const Text('ListView Vertical'),
              ),
              const Spacer(flex: 5),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isVertical = false;
                  });
                },
                child: const Text('ListView Horizontal'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: isVertical
                ? _listViewVerticalWidget()
                : _listViewHorizontalWidget(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _mainPageWidget(context),
    );
  }
}
