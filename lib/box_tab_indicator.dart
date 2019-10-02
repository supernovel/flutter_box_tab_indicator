library box_tab_indicator;

import 'package:flutter/material.dart';

/// Used with [TabBar.indicator]
/// 
/// The [indicatorHeight] defines the box height. if null, use TabBar height
/// The [indicatorColor] defines the box color.
/// The [indicatorRadius] defines the box corner radius.
/// The [tabBarIndicatorSize] specifies the type of TabBarIndicatorSize i.e label or tab.
/// The selected tab bubble is inset from the tab's boundary by [insets] when [tabBarIndicatorSize] is tab.
/// The selected tab bubble is applied padding by [padding] when [tabBarIndicatorSize] is label.
/// 
class BoxTabIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final Radius indicatorRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry insets;
  final TabBarIndicatorSize tabBarIndicatorSize;

  const BoxTabIndicator({
    this.indicatorHeight,
    this.indicatorColor = const Color(0xFF2E2E2E),
    this.indicatorRadius = Radius.zero,
    this.tabBarIndicatorSize = TabBarIndicatorSize.tab,
    this.padding = const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
    this.insets = const EdgeInsets.symmetric(horizontal: 0),
  })  : assert(indicatorRadius != null),
        assert(indicatorColor != null),
        assert(padding != null),
        assert(insets != null);

  @override
  Decoration lerpFrom(Decoration a, double t) {
    if (a is BoxTabIndicator) {
      return BoxTabIndicator(
        padding: EdgeInsetsGeometry.lerp(a.padding, padding, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration lerpTo(Decoration b, double t) {
    if (b is BoxTabIndicator) {
      return BoxTabIndicator(
        padding: EdgeInsetsGeometry.lerp(padding, b.padding, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return _BoxPainter(this, onChanged);
  }
}

class _BoxPainter extends BoxPainter {
  _BoxPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  final BoxTabIndicator decoration;

  double get indicatorHeight => decoration.indicatorHeight;
  Color get indicatorColor => decoration.indicatorColor;
  Radius get indicatorRadius => decoration.indicatorRadius;
  EdgeInsetsGeometry get padding => decoration.padding;
  EdgeInsetsGeometry get insets => decoration.insets;
  TabBarIndicatorSize get tabBarIndicatorSize => decoration.tabBarIndicatorSize;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    assert(rect != null);
    assert(textDirection != null);

    Rect indicator = padding.resolve(textDirection).inflateRect(rect);

    if (tabBarIndicatorSize == TabBarIndicatorSize.tab) {
      indicator = insets.resolve(textDirection).deflateRect(rect);
    }

    return new Rect.fromLTWH(
      indicator.left,
      indicator.top,
      indicator.width,
      indicator.height,
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    Rect rect;

    if (indicatorHeight != null) {
      rect = Offset(offset.dx,
              (configuration.size.height / 2) - indicatorHeight / 2) &
          Size(configuration.size.width, indicatorHeight);
    } else {
      rect = offset & configuration.size;
    }

    final TextDirection textDirection = configuration.textDirection;
    final Rect indicator = _indicatorRectFor(rect, textDirection);
    final Paint paint = Paint();
    paint.color = indicatorColor;
    paint.style = PaintingStyle.fill;

    canvas.drawRRect(
        RRect.fromRectAndRadius(indicator, indicatorRadius), paint);
  }
}
