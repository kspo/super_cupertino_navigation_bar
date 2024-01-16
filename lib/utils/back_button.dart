import 'package:flutter/cupertino.dart';

import 'back_chevron.dart';
import 'back_label.dart';

/// A nav bar back button typically used in [CupertinoNavigationBar].
///
/// This is automatically inserted into [CupertinoNavigationBar] and
/// [CupertinoSliverNavigationBar]'s `leading` slot when
/// `automaticallyImplyLeading` is true.
///
/// When manually inserted, the [CupertinoNavigationBarBackButton] should only
/// be used in routes that can be popped unless a custom [onPressed] is
/// provided.
///
/// Shows a back chevron and the previous route's title when available from
/// the previous [CupertinoPageRoute.title]. If [previousPageTitle] is specified,
/// it will be shown instead.
class SuperCupertinoNavigationBarBackButton extends StatelessWidget {
  /// Construct a [CupertinoNavigationBarBackButton] that can be used to pop
  /// the current route.
  ///
  /// The [color] parameter must not be null.
  const SuperCupertinoNavigationBarBackButton({
    super.key,
    this.color,
    this.previousPageTitle,
    this.onPressed,
  })  : backChevron = null,
        backLabel = null;

  // Allow the back chevron and label to be separately created (and keyed)
  // because they animate separately during page transitions.
  const SuperCupertinoNavigationBarBackButton.assemble(
      this.backChevron, this.backLabel,
      {super.key})
      : previousPageTitle = null,
        color = null,
        onPressed = null;

  /// The [Color] of the back button.
  ///
  /// Can be used to override the color of the back button chevron and label.
  ///
  /// Defaults to [CupertinoTheme]'s `primaryColor` if null.
  final Color? color;

  /// An override for showing the previous route's title. If null, it will be
  /// automatically derived from [CupertinoPageRoute.title] if the current and
  /// previous routes are both [CupertinoPageRoute]s.
  final String? previousPageTitle;

  /// An override callback to perform instead of the default behavior which is
  /// to pop the [Navigator].
  ///
  /// It can, for instance, be used to pop the platform's navigation stack
  /// via [SystemNavigator] instead of Flutter's [Navigator] in add-to-app
  /// situations.
  ///
  /// Defaults to null.
  final VoidCallback? onPressed;

  /// Defaults to null.
  final Widget? backChevron;

  /// Defaults to null.
  final Widget? backLabel;

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? currentRoute = ModalRoute.of(context);
    if (onPressed == null) {
      assert(
        currentRoute?.canPop ?? false,
        'CupertinoNavigationBarBackButton should only be used in routes that can be popped',
      );
    }

    TextStyle actionTextStyle =
        CupertinoTheme.of(context).textTheme.navActionTextStyle;
    if (color != null) {
      actionTextStyle = actionTextStyle.copyWith(
          color: CupertinoDynamicColor.maybeResolve(color, context));
    }

    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Semantics(
        container: true,
        excludeSemantics: true,
        label: 'Back',
        button: true,
        child: DefaultTextStyle(
          style: actionTextStyle,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 50),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(padding: EdgeInsetsDirectional.only(start: 8.0)),
                backChevron ?? const BackChevron(),
                const Padding(padding: EdgeInsetsDirectional.only(start: 6.0)),
                Flexible(
                  child: backLabel ??
                      BackLabel(
                        specifiedPreviousTitle: previousPageTitle,
                        route: currentRoute,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}
