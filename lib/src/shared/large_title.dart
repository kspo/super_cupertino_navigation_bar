import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:super_cupertino_navigation_bar/src/shared/measures.dart';

/// The large title of the navigation bar.
///
/// Magnifies on over-scroll when [CupertinoSliverNavigationBar.stretch]
/// parameter is true.
class LargeTitle extends SingleChildRenderObjectWidget {
  const LargeTitle({super.key, super.child});

  @override
  RenderLargeTitle createRenderObject(BuildContext context) {
    return RenderLargeTitle(
        alignment: AlignmentDirectional.bottomStart
            .resolve(Directionality.of(context)));
  }

  @override
  void updateRenderObject(BuildContext context, RenderLargeTitle renderObject) {
    renderObject.alignment =
        AlignmentDirectional.bottomStart.resolve(Directionality.of(context));
  }
}

class RenderLargeTitle extends RenderShiftedBox {
  RenderLargeTitle({
    required Alignment alignment,
  })  : _alignment = alignment,
        super(null);

  Alignment get alignment => _alignment;
  Alignment _alignment;
  set alignment(Alignment value) {
    if (_alignment == value) {
      return;
    }
    _alignment = value;

    markNeedsLayout();
  }

  double _scale = 1.0;

  @override
  void performLayout() {
    final RenderBox? child = this.child;
    Size childSize = Size.zero;

    size = constraints.biggest;

    if (child == null) {
      return;
    }

    final BoxConstraints childConstraints =
        constraints.widthConstraints().loosen();
    child.layout(childConstraints, parentUsesSize: true);

    final double maxScale = child.size.width != 0.0
        ? clampDouble(constraints.maxWidth / child.size.width, 1.0, 1.1)
        : 1.1;
    _scale = clampDouble(
      1.0 +
          (constraints.maxHeight -
                  (Measures.navBarLargeTitleHeight -
                      Measures.navBarBottomPadding)) /
              (Measures.navBarLargeTitleHeight - Measures.navBarBottomPadding) *
              0.03,
      1.0,
      maxScale,
    );

    childSize = child.size * _scale;
    final BoxParentData childParentData = child.parentData! as BoxParentData;
    childParentData.offset = alignment.alongOffset(size - childSize as Offset);
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    assert(child == this.child);

    super.applyPaintTransform(child, transform);

    transform.scale(_scale, _scale);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final RenderBox? child = this.child;

    if (child == null) {
      layer = null;
    } else {
      final BoxParentData childParentData = child.parentData! as BoxParentData;

      layer = context.pushTransform(
        needsCompositing,
        offset + childParentData.offset,
        Matrix4.diagonal3Values(_scale, _scale, 1.0),
        (PaintingContext context, Offset offset) =>
            context.paintChild(child, offset),
        oldLayer: layer as TransformLayer?,
      );
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final RenderBox? child = this.child;

    if (child == null) {
      return false;
    }

    final Offset childOffset = (child.parentData! as BoxParentData).offset;

    final Matrix4 transform = Matrix4.identity()
      ..scale(1.0 / _scale, 1.0 / _scale, 1.0)
      ..translate(-childOffset.dx, -childOffset.dy);

    return result.addWithRawTransform(
        transform: transform,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          return child.hitTest(result, position: transformed);
        });
  }
}
