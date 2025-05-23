import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/quote.dart';
import '../provider/auth_provider.dart';

class QuotesListScreen extends StatelessWidget {
  final List<Quote> quotes;
  final Function(String) onTapped;
  final Function() onLogout;

  const QuotesListScreen({
    super.key,
    required this.quotes,
    required this.onTapped,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final authWatch = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quotes App"),
      ),
      body: ListView(
        children: [
          for (var quote in quotes)
            ListTile(
              title: Text(quote.author),
              subtitle: Text(quote.quote),
              isThreeLine: true,
              onTap: () => onTapped(quote.id),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final authRead = context.read<AuthProvider>();
          final result = await authRead.logout();
          if (result) onLogout();
        },
        tooltip: "Logout",


        child: authWatch.isLoadingLogout
            ? const CircularProgressIndicator(
          color: Colors.white,
        )
            : const Icon(Icons.logout),
      ),
    );
  }
}