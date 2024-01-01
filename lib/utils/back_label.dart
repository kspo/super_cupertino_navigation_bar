import 'package:flutter/cupertino.dart';

/// A widget that shows next to the back chevron when `automaticallyImplyLeading`
/// is true.
class BackLabel extends StatelessWidget {
  const BackLabel({
    super.key,
    required this.specifiedPreviousTitle,
    required this.route,
  });

  final String? specifiedPreviousTitle;
  final ModalRoute<dynamic>? route;

  // `child` is never passed in into ValueListenableBuilder so it's always
  // null here and unused.
  Widget _buildPreviousTitleWidget(
      BuildContext context, String? previousTitle, Widget? child) {
    if (previousTitle == null) {
      return const SizedBox.shrink();
    }

    Text textWidget = Text(
      previousTitle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    if (previousTitle.length > 12) {
      textWidget = const Text('Back');
    }

    return Align(
      alignment: AlignmentDirectional.centerStart,
      widthFactor: 1.0,
      child: textWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (specifiedPreviousTitle != null) {
      return _buildPreviousTitleWidget(context, specifiedPreviousTitle, null);
    } else if (route is CupertinoRouteTransitionMixin<dynamic> &&
        !route!.isFirst) {
      final CupertinoRouteTransitionMixin<dynamic> cupertinoRoute =
          route! as CupertinoRouteTransitionMixin<dynamic>;
      // There is no timing issue because the previousTitle Listenable changes
      // happen during route modifications before the ValueListenableBuilder
      // is built.
      return ValueListenableBuilder<String?>(
        valueListenable: cupertinoRoute.previousTitle,
        builder: _buildPreviousTitleWidget,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
