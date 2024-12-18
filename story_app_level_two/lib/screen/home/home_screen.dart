import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme/theme_provider.dart';
import 'home_screen_body_widget.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  final Function(String) onTapped;
  final Function() onPostStory;
  final Function() onRefreshHomeScreen;

  const HomeScreen({
    super.key,
    required this.onTapped,
    required this.onPostStory,
    required this.onRefreshHomeScreen,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      widget.onRefreshHomeScreen(); // refresh this after upload story
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.storyApp),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: themeProvider.toggleTheme,
            icon: Icon(
              themeProvider.isDarkMode
                  ? Icons.nightlight_round
                  : Icons.wb_sunny,
              color: themeProvider.isDarkMode ? Colors.white : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () => widget.onPostStory(),
            icon: Icon(
              Icons.add,
              color: themeProvider.isDarkMode ? Colors.white : Colors.grey,
            ),
          ),
        ],
      ),
      body: HomeScreenBodyWidget(onTapped: widget.onTapped),
    );
  }
}
