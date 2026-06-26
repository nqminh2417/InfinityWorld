import 'dart:math';

import 'package:flutter/material.dart';
import 'package:infinity_world/core/config/constants.dart';
import 'package:infinity_world/features/summertime_saga/data/smts_service.dart';
import 'package:infinity_world/features/summertime_saga/domain/smts_progress_model.dart';
import 'package:infinity_world/features/summertime_saga/presentation/widgets/progress_bar.dart';

typedef SmtsProgressLoader = Future<SmtsProgressModel> Function();

class SmtsHomeScreen extends StatefulWidget {
  SmtsHomeScreen({super.key, SmtsProgressLoader? loadProgress, String? logoUrl})
    : loadProgress = loadProgress ?? SmtsService.getProgress,
      logoUrl = logoUrl ?? Cfg.smtsLogoUrl;

  final SmtsProgressLoader loadProgress;
  final String logoUrl;

  @override
  State<SmtsHomeScreen> createState() => _SmtsHomeScreenState();
}

class _SmtsHomeScreenState extends State<SmtsHomeScreen> {
  SmtsProgressModel? _progressData;
  String? _errorMessage;
  bool _isLoading = true;
  int _requestId = 0;

  @override
  void initState() {
    super.initState();
    _fetchProgress(showLoading: false);
  }

  Future<void> _fetchProgress({bool showLoading = true}) async {
    final requestId = ++_requestId;

    if (showLoading) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
        _progressData = null;
      });
    }

    try {
      final data = await widget.loadProgress();

      if (!mounted || requestId != _requestId) return;

      setState(() {
        _progressData = data;
        _errorMessage = null;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted || requestId != _requestId) return;

      setState(() {
        _progressData = null;
        _errorMessage = _messageFor(error);
        _isLoading = false;
      });
    }
  }

  String _messageFor(Object error) {
    if (error is SmtsServiceException) {
      return error.message;
    }

    return 'Failed to load progress.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Summertime Saga')),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF090A0F), Color(0xFF3F4562)],
            stops: [0.0, 1.0],
            transform: GradientRotation(135 * pi / 180),
          ),
        ),
        child: SafeArea(
          top: false,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (widget.logoUrl.isNotEmpty)
                Image.network(
                  widget.logoUrl,
                  errorBuilder:
                      (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        color: Colors.white70,
                        size: 100,
                      ),
                ),
              if (widget.logoUrl.isNotEmpty) const SizedBox(height: 20),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final errorMessage = _errorMessage;
    if (errorMessage != null) {
      return _buildErrorState(errorMessage);
    }

    final progressData = _progressData;
    if (progressData == null) {
      return _buildErrorState('Progress data is unavailable.');
    }

    return _buildProgressContent(progressData);
  }

  Widget _buildProgressContent(SmtsProgressModel progressData) {
    final totals = progressData.totals;
    final issues = progressData.issues;
    final depts = progressData.depts;
    final art = depts?.art;
    final posing = depts?.posing;
    final dialogue = depts?.dialogue;
    final code = depts?.code;
    final audio = depts?.audio;

    if (progressData.version == null ||
        !_hasTotals(totals) ||
        issues?.total == null ||
        !_hasTotals(art) ||
        !_hasTotals(posing) ||
        !_hasTotals(dialogue) ||
        !_hasTotals(code) ||
        !_hasTotals(audio)) {
      return _buildErrorState('Progress data is incomplete.');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 3),
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${progressData.version} - ${totals?.percent?.completed}%',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${totals?.total} Tasks',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF505673)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: ProgressBar(
                    title: 'Art',
                    completed: art?.closed,
                    inProgress: art?.working,
                    total: art?.total,
                    percent: art?.percent,
                    completedColor: const Color(0xff7e8534),
                    inProgressColor: const Color(0xff7e8534),
                    totalColor: const Color(0xff7e8534),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: ProgressBar(
                    title: 'Posing',
                    completed: posing?.closed,
                    inProgress: posing?.working,
                    total: posing?.total,
                    percent: posing?.percent,
                    completedColor: const Color(0xfff1562e),
                    inProgressColor: const Color(0xffbd492f),
                    totalColor: const Color(0xff893c30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: ProgressBar(
                    title: 'Dialogue',
                    completed: dialogue?.closed,
                    inProgress: dialogue?.working,
                    total: dialogue?.total,
                    percent: dialogue?.percent,
                    completedColor: const Color(0xfff1e12e),
                    inProgressColor: const Color(0xff7e8534),
                    totalColor: const Color(0xff7e8534),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: ProgressBar(
                    title: 'Code',
                    completed: code?.closed,
                    inProgress: code?.working,
                    total: code?.total,
                    percent: code?.percent,
                    completedColor: const Color(0xff5ca1bb),
                    inProgressColor: const Color(0xff4c8299),
                    totalColor: const Color(0xff3e6277),
                  ),
                ),
                ProgressBar(
                  title: 'Audio',
                  completed: audio?.closed,
                  inProgress: audio?.working,
                  total: audio?.total,
                  percent: audio?.percent,
                  completedColor: const Color(0xff48506d),
                  inProgressColor: const Color(0xff48506d),
                  totalColor: const Color(0xff48506d),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Text(
            '${issues?.total} Changes in last 24hrs',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.white70, size: 40),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white70),
            ),
            onPressed: () => _fetchProgress(),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  bool _hasTotals(Totals? totals) {
    return totals?.closed != null &&
        totals?.working != null &&
        totals?.total != null &&
        totals?.percent?.completed != null;
  }
}
