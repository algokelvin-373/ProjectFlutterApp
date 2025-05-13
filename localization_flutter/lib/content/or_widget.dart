import 'package:flutter/material.dart';

import '../common.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(
        AppLocalizations.of(context)!.orText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
