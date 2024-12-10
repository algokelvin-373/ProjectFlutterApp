import 'package:flutter/material.dart';

import '../content/free_packet_card.dart';
import '../content/or_widget.dart';
import '../content/paid_packet_card.dart';
import 'max_width_widget.dart';

class PackageList extends StatelessWidget {
  const PackageList({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isPortait = orientation == Orientation.portrait;

    return MaxWidthWidget(
      maxWidth: 600,
      child: isPortait
          ? Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                PaidPackageCard(),
                OrWidget(),
                FreePackageCard(),
              ],
            )
          : IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Expanded(child: PaidPackageCard()),
                  OrWidget(),
                  Expanded(child: FreePackageCard()),
                ],
              ),
            ),
    );
  }
}
