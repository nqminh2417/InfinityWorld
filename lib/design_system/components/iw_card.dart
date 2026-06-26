import 'package:flutter/material.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_radius.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';

class IwCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const IwCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(IwSpacing.cardPadding),
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final borderRadius = IwRadius.cardBorderRadius;

    final content = Padding(padding: padding, child: child);

    final card = Material(
      color: IwColors.surface1(brightness),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: IwColors.border(brightness)),
      ),
      child:
          onTap == null
              ? content
              : InkWell(
                borderRadius: borderRadius,
                onTap: onTap,
                child: content,
              ),
    );

    if (margin == null) {
      return card;
    }

    return Padding(padding: margin!, child: card);
  }
}
