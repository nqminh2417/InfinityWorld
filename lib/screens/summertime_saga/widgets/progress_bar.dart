import 'package:flutter/material.dart';

import '../models/smts_progress_model.dart';

class ProgressBar extends StatelessWidget {
  final String? title;
  final double? height;
  final int? completed;
  final int? inProgress;
  final int? total;
  final Color? completedColor;
  final Color? inProgressColor;
  final Color? totalColor;
  final Percent? percent;

  const ProgressBar({
    super.key,
    this.title = "Title",
    this.height = 21,
    this.completed = 4,
    this.inProgress = 3,
    this.total = 10,
    this.completedColor = const Color(0xFF337CCF),
    this.inProgressColor = const Color(0xFF1450A3),
    this.totalColor = const Color(0xFF191D88),
    this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final parentWidth = constraints.maxWidth;
        final completedValue = completed ?? 0;
        final inProgressValue = inProgress ?? 0;
        final totalValue = total ?? 0;
        final inProgressWidth = _barWidth(
          parentWidth,
          completedValue + inProgressValue,
          totalValue,
        );
        final completedWidth = _barWidth(
          parentWidth,
          completedValue,
          totalValue,
        );

        return Container(
          width: parentWidth,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xB0B2B500),
              width: 0.5,
              style: BorderStyle.solid,
            ),
          ),
          child: Stack(
            children: [
              Container(
                width: parentWidth,
                decoration: BoxDecoration(color: totalColor),
              ),
              Container(
                width: inProgressWidth,
                decoration: BoxDecoration(color: inProgressColor),
              ),
              Container(
                width: completedWidth,
                decoration: BoxDecoration(color: completedColor),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '[$completedValue/$totalValue] ${percent?.completed ?? '0'}%',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double _barWidth(double parentWidth, int value, int totalValue) {
    if (totalValue <= 0) {
      return 0;
    }

    return (value.clamp(0, totalValue) / totalValue) * parentWidth;
  }
}
