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
        double parentwidth = constraints.maxWidth;
        return Container(
          width: parentwidth,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xB0B2B500), width: 0.5, style: BorderStyle.solid),
          ),
          child: Stack(
            children: [
              Container(width: parentwidth, decoration: BoxDecoration(color: totalColor)),
              Container(
                width: total == 0 ? parentwidth : (((completed! + inProgress!) / total!) * parentwidth),
                decoration: BoxDecoration(color: inProgressColor),
              ),
              Container(
                width: total == 0 ? parentwidth : ((completed! / total!) * parentwidth),
                decoration: BoxDecoration(color: completedColor),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(title!, style: const TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '[$completed/$total] ${percent!.completed}%',
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
}
