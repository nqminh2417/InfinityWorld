import 'dart:math';

import 'package:flutter/material.dart';
import 'package:infinity_world/core/config/constants.dart';
import 'package:infinity_world/screens/summertime_saga/models/smts_progress_model.dart';
import 'package:infinity_world/screens/summertime_saga/services/smts_service.dart';
import 'package:infinity_world/screens/summertime_saga/widgets/progress_bar.dart';

class SmtsHomeScreen extends StatefulWidget {
  const SmtsHomeScreen({super.key});

  @override
  State<SmtsHomeScreen> createState() => _SmtsHomeScreenState();
}

class _SmtsHomeScreenState extends State<SmtsHomeScreen> {
  SmtsProgressModel? progressData;
  final String _logoUrl = Cfg.smtsLogoUrl;

  @override
  void initState() {
    super.initState();
    _fetchProgress();
  }

  Future<void> _fetchProgress() async {
    try {
      final data = await SmtsService.getProgress();
      setState(() {
        progressData = data;
      });
    } catch (error) {
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Summertime Saga')),
      body: Container(
        width: double.infinity, //MediaQuery.of(context).size.width
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF090A0F), Color(0xFF3F4562)],
            stops: [0.0, 1.0],
            transform: GradientRotation(135 * pi / 180),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_logoUrl.isNotEmpty) // Kiểm tra nếu có URL logo
                Image.network(
                  _logoUrl,
                  // height: 100,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 100),
                ),
              SizedBox(height: 20),
              progressData != null
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 0, right: 0, bottom: 3.0, left: 0),
                        padding: const EdgeInsets.only(top: 0.0, right: 1.0, bottom: 0.0, left: 1.0),
                        child: Row(
                          children: [
                            Text(
                              '${progressData!.version} - ${progressData!.totals!.percent!.completed}%',
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            const Spacer(),
                            Text(
                              '${progressData!.totals!.total} Tasks',
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10), // Add some spacing between rows
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(border: Border.all(color: const Color(0xFF505673))),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: ProgressBar(
                                  height: 21,
                                  title: 'Art',
                                  completed: progressData!.depts!.art!.closed,
                                  inProgress: progressData!.depts!.art!.working,
                                  total: progressData!.depts!.art!.total,
                                  percent: progressData!.depts!.art!.percent,
                                  completedColor: const Color(0xff7e8534),
                                  inProgressColor: const Color(0xff7e8534),
                                  totalColor: const Color(0xff7e8534),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: ProgressBar(
                                  height: 21,
                                  title: 'Posing',
                                  completed: progressData!.depts!.posing!.closed,
                                  inProgress: progressData!.depts!.posing!.working,
                                  total: progressData!.depts!.posing!.total,
                                  percent: progressData!.depts!.posing!.percent,
                                  completedColor: const Color(0xfff1562e),
                                  inProgressColor: const Color(0xffbd492f),
                                  totalColor: const Color(0xff893c30),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: ProgressBar(
                                  height: 21,
                                  title: 'Dialogue',
                                  completed: progressData!.depts!.dialogue!.closed,
                                  inProgress: progressData!.depts!.dialogue!.working,
                                  total: progressData!.depts!.dialogue!.total,
                                  percent: progressData!.depts!.dialogue!.percent,
                                  completedColor: const Color(0xfff1e12e),
                                  inProgressColor: const Color(0xff7e8534),
                                  totalColor: const Color(0xff7e8534),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: ProgressBar(
                                  height: 21,
                                  title: 'Code',
                                  completed: progressData!.depts!.code!.closed,
                                  inProgress: progressData!.depts!.code!.working,
                                  total: progressData!.depts!.code!.total,
                                  percent: progressData!.depts!.code!.percent,
                                  completedColor: const Color(0xff5ca1bb),
                                  inProgressColor: const Color(0xff4c8299),
                                  totalColor: const Color(0xff3e6277),
                                ),
                              ),
                              ProgressBar(
                                height: 21,
                                title: 'Audio',
                                completed: progressData!.depts!.audio!.closed,
                                inProgress: progressData!.depts!.audio!.working,
                                total: progressData!.depts!.audio!.total,
                                percent: progressData!.depts!.audio!.percent,
                                completedColor: const Color(0xff48506d),
                                inProgressColor: const Color(0xff48506d),
                                totalColor: const Color(0xff48506d),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 0, right: 0, bottom: 30.0, left: 0),
                        padding: const EdgeInsets.only(top: 0.0, right: 1.0, bottom: 0.0, left: 1.0),
                        child: Row(
                          children: [
                            Text(
                              '${progressData!.issues!.total} Changes in last 24hrs',
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                  : const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
