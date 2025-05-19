import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Train',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPageState(title: 'Flutter Training - GridView'),
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
  int gridColumnCount = 2;

  // Generate 20 items
  final List<Map<String, dynamic>> items = List.generate(
    20,
    (index) => {
      'icon': Icons.star,
      'label': 'Item ${index + 1}',
    },
  );

  Widget _gridViewWidget() {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridColumnCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: gridColumnCount >= 4 ? 0.7 : 0.9,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final iconSize = gridColumnCount >= 5
            ? 28.0
            : gridColumnCount == 4
                ? 32.0
                : 40.0;
        final fontSize = gridColumnCount >= 5 ? 12.0 : 14.0;
        final spacing = gridColumnCount >= 5 ? 2.0 : 4.0;

        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item['icon'], size: iconSize),
              SizedBox(height: spacing),
              Text(
                item['label'],
                style: TextStyle(fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _mainPage(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (i) {
              final count = i + 2;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      gridColumnCount = count;
                    });
                  },
                  child: Text('$count Col'),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: _gridViewWidget(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _mainPage(context),
    );
  }
}
