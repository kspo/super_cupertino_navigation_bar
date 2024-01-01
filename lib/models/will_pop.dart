import 'package:flutter/material.dart';

/// An enhanced version of [WillPopScope] that adds additional functionality.
class ConditionalWillPopScope extends StatefulWidget {
  /// Creates a widget that registers a callback to veto attempts by the user to
  /// dismiss the enclosing [ModalRoute].
  ///
  /// The `child` argument must not be `null`.
  const ConditionalWillPopScope({
    Key? key,
    required this.child,
    required this.onWillPop,
    required this.shouldAddCallback,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

  /// Called to veto attempts by the user to dismiss the enclosing [ModalRoute].
  ///
  /// If the callback returns a [Future] that resolves to `false`, the enclosing
  /// route will not be popped.
  final WillPopCallback? onWillPop;

  /// Determines if the `onWillPop` callback should be added to the enclosing [ModalRoute].
  final bool shouldAddCallback;

  @override
  _ConditionalWillPopScopeState createState() =>
      _ConditionalWillPopScopeState();
}

class _ConditionalWillPopScopeState extends State<ConditionalWillPopScope> {
  ModalRoute<dynamic>? _route;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.onWillPop != null) {
      // Remove callback from the "old" route.
      _route?.removeScopedWillPopCallback(widget.onWillPop!);

      // Update the reference to the "current" route.
      _route = ModalRoute.of(context);

      // Add the callbacks to the new "current" route.
      if (widget.shouldAddCallback) {
        _route?.addScopedWillPopCallback(widget.onWillPop!);
      }
    }
  }

  @override
  void didUpdateWidget(ConditionalWillPopScope oldWidget) {
    super.didUpdateWidget(oldWidget);

    assert(_route == ModalRoute.of(context));

    if (widget.onWillPop != oldWidget.onWillPop ||
        widget.shouldAddCallback != oldWidget.shouldAddCallback) {
      // Remove callbacks of the old widget state.
      if (oldWidget.onWillPop != null) {
        _route?.removeScopedWillPopCallback(oldWidget.onWillPop!);
      }

      // Add callbacks of the new widget state.
      if (widget.onWillPop != null && widget.shouldAddCallback) {
        _route?.addScopedWillPopCallback(widget.onWillPop!);
      }
    }
  }

  @override
  void dispose() {
    if (widget.onWillPop != null) {
      _route?.removeScopedWillPopCallback(widget.onWillPop!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
