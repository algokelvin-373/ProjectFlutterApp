import 'package:flutter/material.dart';

class BufferSliderControllerWidget extends StatelessWidget {
  final String minText;
  final String maxText;
  final double maxValue;
  final double currentValue;
  final Function(double) onChanged;

  const BufferSliderControllerWidget({
    super.key,
    required this.minText,
    required this.maxText,
    required this.maxValue,
    required this.currentValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.white54,
            thumbColor: Colors.white,
            overlayColor: Colors.white24,
          ),
          child: Slider(
            value: currentValue,
            min: 0,
            max: maxValue,
            onChanged: (value) => onChanged(value),
          ),
        ),
      ],
    );
  }
}
