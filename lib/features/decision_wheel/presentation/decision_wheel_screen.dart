import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_radius.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';

typedef DecisionWheelPickIndex = int Function(int optionCount);
typedef DecisionWheelShuffleOptions =
    List<String> Function(List<String> options);

const _spinDuration = Duration(milliseconds: 1600);
const _segmentStartAngle = -math.pi / 2;
const _historySheetMaxScreenFraction = 0.61;
// ponytail: reserve current header/actions/padding height; measure it if this sheet gains more chrome.
const _historySheetFixedContentHeight = 148.0;
const _historyItemHeight = 50.0;
const _decisionWheelPalette = [
  Color(0xFF2F6FEF),
  Color(0xFFE71D36),
  Color(0xFFF7C62F),
  Color(0xFF16A34A),
  Color(0xFF6B5BFF),
  Color(0xFF4CC2FF),
];

enum _DecisionResultAction { cancel, remove }

class _DecisionWheelHistoryEntry {
  final int order;
  final String option;
  final Color color;

  const _DecisionWheelHistoryEntry({
    required this.order,
    required this.option,
    required this.color,
  });
}

int _systemPickIndex(int optionCount) => math.Random().nextInt(optionCount);

List<String> _systemShuffleOptions(List<String> options) {
  final shuffled = List<String>.of(options)..shuffle(math.Random());
  return shuffled.toList(growable: false);
}

class DecisionWheelScreen extends StatefulWidget {
  final DecisionWheelPickIndex pickIndex;
  final DecisionWheelShuffleOptions shuffleOptions;

  const DecisionWheelScreen({
    super.key,
    this.pickIndex = _systemPickIndex,
    this.shuffleOptions = _systemShuffleOptions,
  });

  @override
  State<DecisionWheelScreen> createState() => _DecisionWheelScreenState();
}

class _DecisionWheelScreenState extends State<DecisionWheelScreen>
    with SingleTickerProviderStateMixin {
  final _optionsController = TextEditingController();
  late final AnimationController _spinController;

  Animation<double>? _spinAnimation;
  double _rotationTurns = 0;
  int? _selectedIndex;
  int _nextHistoryOrder = 1;
  String? _errorText;
  final List<_DecisionWheelHistoryEntry> _history = [];

  bool get _isSpinning => _spinController.isAnimating;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(vsync: this, duration: _spinDuration)
      ..addListener(() {
        final animation = _spinAnimation;
        if (animation == null) {
          return;
        }

        setState(() {
          _rotationTurns = animation.value;
        });
      });
  }

  @override
  void dispose() {
    _spinController.dispose();
    _optionsController.dispose();
    super.dispose();
  }

  void _spin() {
    if (_isSpinning) {
      return;
    }

    final options = _parseOptions(_optionsController.text);

    if (options.length < 2) {
      setState(() {
        _selectedIndex = null;
        _errorText = 'Add at least two options.';
      });
      return;
    }

    final rawIndex = widget.pickIndex(options.length);
    final selectedIndex = rawIndex.clamp(0, options.length - 1).toInt();
    final targetTurns = _targetTurnsFor(options.length, selectedIndex);

    _spinAnimation = Tween<double>(
      begin: _rotationTurns,
      end: targetTurns,
    ).animate(
      CurvedAnimation(parent: _spinController, curve: Curves.easeOutCubic),
    );

    setState(() {
      _selectedIndex = null;
      _errorText = null;
    });

    _spinController.forward(from: 0).whenComplete(() {
      if (!mounted) {
        return;
      }

      setState(() {
        _rotationTurns = targetTurns;
        _selectedIndex = selectedIndex;
        _history.add(
          _DecisionWheelHistoryEntry(
            order: _nextHistoryOrder,
            option: options[selectedIndex],
            color: decisionWheelSegmentColor(selectedIndex, options.length),
          ),
        );
        _nextHistoryOrder += 1;
      });
      _showSelectedOptionDialog(options, selectedIndex);
    });
  }

  Future<void> _showSelectedOptionDialog(
    List<String> options,
    int selectedIndex,
  ) async {
    final option = options[selectedIndex];
    final color = decisionWheelSegmentColor(selectedIndex, options.length);
    final action = await showDialog<_DecisionResultAction>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return _DecisionResultDialog(
          option: option,
          color: color,
          onCancel: () {
            Navigator.of(dialogContext).pop(_DecisionResultAction.cancel);
          },
          onRemove: () {
            Navigator.of(dialogContext).pop(_DecisionResultAction.remove);
          },
        );
      },
    );

    if (!mounted) {
      return;
    }

    if (action == _DecisionResultAction.remove) {
      _removeSelectedOption();
      return;
    }

    _cancelResult();
  }

  void _cancelResult() {
    if (_isSpinning) {
      return;
    }

    setState(() {
      _selectedIndex = null;
    });
  }

  void _removeSelectedOption() {
    if (_isSpinning || _selectedIndex == null) {
      return;
    }

    final options = _parseOptions(_optionsController.text);
    if (_selectedIndex! >= options.length) {
      _cancelResult();
      return;
    }

    final updatedOptions = List<String>.of(options)..removeAt(_selectedIndex!);
    _setOptionsText(updatedOptions);

    setState(() {
      _selectedIndex = null;
      _errorText =
          updatedOptions.length < 2 ? 'Add at least two options.' : null;
    });
  }

  void _shuffleEntries() {
    if (_isSpinning) {
      return;
    }

    final options = _parseOptions(_optionsController.text);
    if (options.length < 2) {
      return;
    }

    _setOptionsText(widget.shuffleOptions(options));
    _clearWheelState();
  }

  void _sortEntries() {
    if (_isSpinning) {
      return;
    }

    final options = _parseOptions(_optionsController.text);
    final sorted = List<String>.of(options)..sort((left, right) {
      final folded = left.toLowerCase().compareTo(right.toLowerCase());
      return folded == 0 ? left.compareTo(right) : folded;
    });

    _setOptionsText(sorted);
    _clearWheelState();
  }

  void _clearHistory() {
    setState(() {
      _history.clear();
      _nextHistoryOrder = 1;
    });
  }

  void _showHistorySheet() {
    if (_isSpinning) {
      return;
    }

    final screenHeight = MediaQuery.sizeOf(context).height;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final brightness = Theme.of(context).brightness;
            final history = _history.reversed.toList(growable: false);
            final maxSheetHeight =
                screenHeight * _historySheetMaxScreenFraction;
            final maxListHeight = math.max(
              0.0,
              maxSheetHeight - _historySheetFixedContentHeight,
            );
            final historyListHeight = math.min(
              history.length * _historyItemHeight +
                  math.max(0, history.length - 1),
              maxListHeight,
            );

            return SafeArea(
              child: ConstrainedBox(
                key: const ValueKey('decision-wheel-history-sheet'),
                constraints: BoxConstraints(maxHeight: maxSheetHeight),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    IwSpacing.cardPadding,
                    0,
                    IwSpacing.cardPadding,
                    IwSpacing.space4,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.history_rounded,
                            color: IwColors.secondary(brightness),
                          ),
                          const SizedBox(width: IwSpacing.space8),
                          Text(
                            'History',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: IwSpacing.space12),
                      if (history.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: IwSpacing.space12,
                          ),
                          child: _DecisionHistoryEmptyState(
                            brightness: brightness,
                          ),
                        )
                      else
                        SizedBox(
                          height: historyListHeight,
                          child: ListView.separated(
                            itemCount: history.length,
                            separatorBuilder:
                                (_, _) => Divider(
                                  height: 1,
                                  thickness: 0.6,
                                  color: IwColors.border(
                                    brightness,
                                  ).withValues(alpha: 0.6),
                                ),
                            itemBuilder: (context, index) {
                              final entry = history[index];
                              return SizedBox(
                                height: _historyItemHeight,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: entry.color,
                                        borderRadius: BorderRadius.circular(
                                          IwRadius.radiusFull,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: IwSpacing.space12),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            entry.option,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleSmall?.copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              height: 1.1,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            'Spin #${entry.order}',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.labelSmall?.copyWith(
                                              height: 1.15,
                                              color: IwColors.textSecondary(
                                                brightness,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      tooltip: 'Copy result',
                                      constraints: const BoxConstraints(
                                        minWidth: 40,
                                        minHeight: 40,
                                      ),
                                      padding: EdgeInsets.zero,
                                      iconSize: 20,
                                      onPressed: () {
                                        _copyHistoryOption(
                                          context,
                                          entry.option,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.content_copy_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: IwSpacing.space4),
                      Wrap(
                        alignment: WrapAlignment.end,
                        spacing: IwSpacing.space8,
                        runSpacing: IwSpacing.space8,
                        children: [
                          TextButton.icon(
                            onPressed:
                                history.isEmpty
                                    ? null
                                    : () {
                                      _clearHistory();
                                      setSheetState(() {});
                                    },
                            icon: const Icon(Icons.delete_sweep_rounded),
                            label: const Text('Clear history'),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.of(sheetContext).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _copyHistoryOption(BuildContext context, String option) async {
    await Clipboard.setData(ClipboardData(text: option));
    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Copied to clipboard'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _clearWheelState() {
    setState(() {
      _selectedIndex = null;
      _errorText = null;
    });
  }

  double _targetTurnsFor(int optionCount, int selectedIndex) {
    final segmentAngle = math.pi * 2 / optionCount;
    final selectedCenterAngle =
        _segmentStartAngle + segmentAngle * (selectedIndex + 0.5);
    final targetFraction = ((-selectedCenterAngle / (math.pi * 2)) % 1 + 1) % 1;
    final currentFraction = (_rotationTurns % 1 + 1) % 1;
    final fractionalDelta = (targetFraction - currentFraction + 1) % 1;

    return _rotationTurns + 4 + fractionalDelta;
  }

  int? _activeSegmentIndex(int optionCount) {
    if (optionCount == 0) {
      return null;
    }

    final segmentAngle = math.pi * 2 / optionCount;
    final rotationRadians = _rotationTurns * math.pi * 2;
    final localAngle =
        ((-_segmentStartAngle - rotationRadians) % (math.pi * 2) +
            math.pi * 2) %
        (math.pi * 2);

    return (localAngle / segmentAngle).floor().clamp(0, optionCount - 1);
  }

  List<String> _parseOptions(String input) {
    return input
        .split(RegExp(r'[;\n]'))
        .map((option) => option.trim())
        .where((option) => option.isNotEmpty)
        .toList(growable: false);
  }

  void _setOptionsText(List<String> options) {
    final text = options.join('\n');
    _optionsController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final options = _parseOptions(_optionsController.text);
    final activeIndex = _activeSegmentIndex(options.length);
    final selectedIndex =
        _selectedIndex != null && _selectedIndex! < options.length
            ? _selectedIndex
            : null;
    final pointerColor = decisionWheelSegmentColor(
      _isSpinning ? activeIndex ?? 0 : selectedIndex ?? activeIndex ?? 0,
      options.length,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Decision Wheel')),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(IwSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Spin a decision',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: IwSpacing.space8),
              Text(
                'Add one option per line, then spin the wheel locally.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: IwColors.textSecondary(brightness),
                ),
              ),
              const SizedBox(height: IwSpacing.space16),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: DecisionWheelFace(
                      options: options,
                      rotationTurns: _rotationTurns,
                      pointerColor: pointerColor,
                      activeIndex: activeIndex,
                      selectedIndex: selectedIndex,
                      onSpin: _spin,
                      enabled: !_isSpinning,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: IwSpacing.space16),
              IwCard(
                key: const ValueKey('decision-wheel-entries-card'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Entries',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: IwSpacing.space8),
                    Wrap(
                      spacing: IwSpacing.space8,
                      runSpacing: IwSpacing.space8,
                      children: [
                        OutlinedButton.icon(
                          onPressed: _isSpinning ? null : _shuffleEntries,
                          icon: const Icon(Icons.shuffle_rounded),
                          label: const Text('Shuffle'),
                        ),
                        OutlinedButton.icon(
                          onPressed: _isSpinning ? null : _sortEntries,
                          icon: const Icon(Icons.sort_by_alpha_rounded),
                          label: const Text('Sort'),
                        ),
                        OutlinedButton.icon(
                          onPressed: _isSpinning ? null : _showHistorySheet,
                          icon: const Icon(Icons.history_rounded),
                          label: const Text('History'),
                        ),
                      ],
                    ),
                    const SizedBox(height: IwSpacing.space12),
                    TextField(
                      controller: _optionsController,
                      enabled: !_isSpinning,
                      minLines: 4,
                      maxLines: 6,
                      scrollPadding: const EdgeInsets.only(
                        bottom: IwSpacing.space32,
                      ),
                      scrollPhysics: const ClampingScrollPhysics(),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: const OutlineInputBorder(),
                        errorText: _errorText,
                        hintText: 'Movie\nPizza\nStudy or Movie; Pizza; Study',
                        labelText: 'One entry per line or semicolon',
                      ),
                      onChanged: (_) {
                        setState(() {
                          _selectedIndex = null;
                          _errorText = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DecisionWheelFace extends StatelessWidget {
  final List<String> options;
  final double rotationTurns;
  final Color pointerColor;
  final int? activeIndex;
  final int? selectedIndex;
  final VoidCallback onSpin;
  final bool enabled;

  const DecisionWheelFace({
    super.key,
    required this.options,
    required this.rotationTurns,
    required this.pointerColor,
    required this.activeIndex,
    required this.selectedIndex,
    required this.onSpin,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final side = math.min(constraints.maxWidth, constraints.maxHeight);
        final centerTargetSize =
            math.max(72.0, side * 0.24).clamp(72.0, 116.0).toDouble();

        return Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: DecisionWheelPainter(
                options: options,
                rotationTurns: rotationTurns,
                pointerColor: pointerColor,
                activeIndex: activeIndex,
                selectedIndex: selectedIndex,
                brightness: Theme.of(context).brightness,
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Center(
              child: Semantics(
                button: true,
                label: 'Spin decision wheel',
                enabled: enabled,
                child: GestureDetector(
                  key: const ValueKey('decision-wheel-center-spin-button'),
                  behavior: HitTestBehavior.opaque,
                  onTap: enabled ? onSpin : null,
                  child: SizedBox.square(dimension: centerTargetSize),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class DecisionWheelPainter extends CustomPainter {
  final List<String> options;
  final double rotationTurns;
  final Color pointerColor;
  final int? activeIndex;
  final int? selectedIndex;
  final Brightness brightness;
  final TextStyle? textStyle;

  const DecisionWheelPainter({
    required this.options,
    required this.rotationTurns,
    required this.pointerColor,
    required this.activeIndex,
    required this.selectedIndex,
    required this.brightness,
    required this.textStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final side = math.min(size.width, size.height);
    final center = Offset(size.width / 2 - side * 0.02, size.height / 2);
    final radius = side / 2 - 28;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final borderPaint =
        Paint()
          ..color = IwColors.border(brightness)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
    final fillPaint = Paint()..style = PaintingStyle.fill;

    if (options.isEmpty) {
      fillPaint.color = IwColors.surface2(brightness);
      canvas.drawCircle(center, radius, fillPaint);
      canvas.drawCircle(center, radius, borderPaint);
      _paintCenteredText(
        canvas,
        'Add options',
        center,
        radius * 1.4,
        textStyle?.copyWith(color: IwColors.textSecondary(brightness)) ??
            TextStyle(color: IwColors.textSecondary(brightness)),
        0,
      );
      _paintPointer(canvas, center, radius);
      return;
    }

    final wheelPath = Path()..addOval(rect);
    canvas.drawShadow(wheelPath, Colors.black, 4, true);

    final segmentAngle = math.pi * 2 / options.length;
    final rotationRadians = rotationTurns * math.pi * 2;

    for (var index = 0; index < options.length; index += 1) {
      final isSelected = selectedIndex == index;
      final isActive = activeIndex == index;
      fillPaint.color = decisionWheelSegmentColor(
        index,
        options.length,
      ).withValues(alpha: selectedIndex != null && !isSelected ? 0.38 : 0.96);
      canvas.drawArc(
        rect,
        _segmentStartAngle + rotationRadians + segmentAngle * index,
        segmentAngle,
        true,
        fillPaint,
      );

      if (isSelected || isActive) {
        final highlightPaint =
            Paint()
              ..color = Colors.white.withValues(alpha: 0.16)
              ..style = PaintingStyle.stroke
              ..strokeWidth = isSelected ? 5 : 3;
        canvas.drawArc(
          rect.deflate(3),
          _segmentStartAngle + rotationRadians + segmentAngle * index + 0.01,
          segmentAngle - 0.02,
          true,
          highlightPaint,
        );
      }
    }

    final dividerPaint =
        Paint()
          ..color = Colors.white.withValues(alpha: 0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2;
    for (var index = 0; index < options.length; index += 1) {
      final angle = _segmentStartAngle + rotationRadians + segmentAngle * index;
      canvas.drawLine(
        center,
        center + Offset(math.cos(angle), math.sin(angle)) * radius,
        dividerPaint,
      );
    }

    canvas.drawCircle(center, radius, borderPaint);
    _paintSegmentLabels(canvas, center, radius, segmentAngle, rotationRadians);
    _paintCenter(canvas, center, radius);
    _paintPointer(canvas, center, radius);
  }

  void _paintSegmentLabels(
    Canvas canvas,
    Offset center,
    double radius,
    double segmentAngle,
    double rotationRadians,
  ) {
    if (options.length > 18) {
      return;
    }

    for (var index = 0; index < options.length; index += 1) {
      final angle =
          _segmentStartAngle + rotationRadians + segmentAngle * (index + 0.5);
      final textColor =
          ThemeData.estimateBrightnessForColor(
                    decisionWheelSegmentColor(index, options.length),
                  ) ==
                  Brightness.dark
              ? Colors.white
              : const Color(0xFF101827);
      final style = (textStyle ?? const TextStyle()).copyWith(
        color: textColor,
        fontSize: math.max(12, math.min(18, radius * 0.085)),
        fontWeight: FontWeight.w700,
      );
      final labelCenter =
          center + Offset(math.cos(angle), math.sin(angle)) * (radius * 0.58);
      var labelRotation = angle;

      if (labelRotation > math.pi / 2 && labelRotation < math.pi * 1.5) {
        labelRotation += math.pi;
      }

      _paintCenteredText(
        canvas,
        options[index],
        labelCenter,
        radius * 0.58,
        style,
        labelRotation,
      );
    }
  }

  void _paintPointer(Canvas canvas, Offset center, double radius) {
    final pointerPaint =
        Paint()
          ..color = pointerColor
          ..style = PaintingStyle.fill;
    final outlinePaint =
        Paint()
          ..color = Colors.white.withValues(alpha: 0.88)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5;
    final pointerPath =
        Path()
          ..moveTo(center.dx + radius - 3, center.dy)
          ..lineTo(center.dx + radius + 26, center.dy - 17)
          ..lineTo(center.dx + radius + 26, center.dy + 17)
          ..close();

    canvas.drawShadow(pointerPath, Colors.black, 5, true);
    canvas.drawPath(pointerPath, pointerPaint);
    canvas.drawPath(pointerPath, outlinePaint);
  }

  void _paintCenter(Canvas canvas, Offset center, double radius) {
    final centerRadius = math.max(34.0, radius * 0.2);
    final surfaceColor =
        brightness == Brightness.dark ? IwColors.darkTextPrimary : Colors.white;
    final centerPaint =
        Paint()
          ..color = surfaceColor
          ..style = PaintingStyle.fill;
    final centerBorderPaint =
        Paint()
          ..color = pointerColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4;

    canvas.drawCircle(center, centerRadius, centerPaint);
    canvas.drawCircle(center, centerRadius, centerBorderPaint);
    _paintCenteredText(
      canvas,
      'SPIN',
      center,
      centerRadius * 1.5,
      (textStyle ?? const TextStyle()).copyWith(
        color: IwColors.lightTextPrimary,
        fontSize: math.max(12, centerRadius * 0.28),
        fontWeight: FontWeight.w800,
      ),
      0,
    );
  }

  void _paintCenteredText(
    Canvas canvas,
    String text,
    Offset center,
    double maxWidth,
    TextStyle style,
    double rotation,
  ) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      ellipsis: '...',
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    painter.paint(canvas, Offset(-painter.width / 2, -painter.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant DecisionWheelPainter oldDelegate) {
    return oldDelegate.options.join('\n') != options.join('\n') ||
        oldDelegate.rotationTurns != rotationTurns ||
        oldDelegate.pointerColor != pointerColor ||
        oldDelegate.activeIndex != activeIndex ||
        oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.brightness != brightness ||
        oldDelegate.textStyle != textStyle;
  }
}

class _DecisionHistoryEmptyState extends StatelessWidget {
  final Brightness brightness;

  const _DecisionHistoryEmptyState({required this.brightness});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.history_toggle_off_rounded,
            color: IwColors.textSecondary(brightness),
          ),
          const SizedBox(height: IwSpacing.space8),
          Text('No spins yet', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: IwSpacing.space4),
          Text(
            'Completed spins will appear here.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: IwColors.textSecondary(brightness),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _DecisionResultDialog extends StatelessWidget {
  final String option;
  final Color color;
  final VoidCallback onCancel;
  final VoidCallback onRemove;

  const _DecisionResultDialog({
    required this.option,
    required this.color,
    required this.onCancel,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final foregroundColor =
        ThemeData.estimateBrightnessForColor(color) == Brightness.dark
            ? Colors.white
            : IwColors.lightTextPrimary;

    return AlertDialog(
      key: const ValueKey('decision-wheel-result-dialog'),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: IwRadius.cardBorderRadius,
        side: BorderSide(color: color.withValues(alpha: 0.9), width: 1.4),
      ),
      titlePadding: EdgeInsets.zero,
      title: Container(
        color: color.withValues(
          alpha: brightness == Brightness.dark ? 0.3 : 0.16,
        ),
        padding: const EdgeInsets.all(IwSpacing.cardPadding),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: IwSpacing.space8),
            Expanded(
              child: Text(
                'Selected option',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      content: Text(
        option,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: IwColors.textPrimary(brightness),
        ),
      ),
      actions: [
        OutlinedButton.icon(
          onPressed: onCancel,
          icon: const Icon(Icons.close_rounded),
          label: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: onRemove,
          style: FilledButton.styleFrom(
            backgroundColor: color,
            foregroundColor: foregroundColor,
          ),
          icon: const Icon(Icons.delete_outline_rounded),
          label: const Text('Remove'),
        ),
      ],
    );
  }
}

Color decisionWheelSegmentColor(int index, int optionCount) {
  if (optionCount <= 0) {
    return _decisionWheelPalette.first;
  }

  final paletteIndex = index % _decisionWheelPalette.length;
  if (optionCount > 1 && index == optionCount - 1 && paletteIndex == 0) {
    return _decisionWheelPalette[1];
  }

  return _decisionWheelPalette[paletteIndex];
}
