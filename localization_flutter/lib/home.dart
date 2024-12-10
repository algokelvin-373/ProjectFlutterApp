import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:localization_flutter/widget/flag_icon_widget.dart';

import 'content/benefit_widget.dart';
import 'content/header_widget.dart';
import 'widget/max_width_widget.dart';
import 'widget/packet_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/dicoding-academy.png"),
        ),
        title: const Text("Dicoding Academy"),
        actions: [
          const FlagIconWidget(),
          IconButton(
            onPressed: () {
              AppSettings.openAppSettings();
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: MaxWidthWidget(
        maxWidth: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              CostWidget(),
              PackageList(),
              SizedBox(height: 20),
              BenefitWidget(),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
