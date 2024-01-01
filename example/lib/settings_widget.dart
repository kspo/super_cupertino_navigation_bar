import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/models/super_search_bar.model.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({
    super.key,
    required this.scrollBehavior,
    required this.animationBehavior,
    required this.alwaysSliderValue,
    required this.focusedSliderValue,
    required this.unfocusedSliderValue,
    required this.largeTitleEnabled,
    required this.searchBarEnabled,
    required this.stretch,
    required this.resultBehavior,
  });
  final SearchBarScrollBehavior scrollBehavior;
  final SearchBarAnimationBehavior animationBehavior;
  final double unfocusedSliderValue;
  final double focusedSliderValue;
  final double alwaysSliderValue;
  final bool largeTitleEnabled;
  final bool searchBarEnabled;
  final bool stretch;
  final SearchBarResultBehavior resultBehavior;

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  late SearchBarScrollBehavior _scrollBehavior;
  late SearchBarAnimationBehavior _animationBehavior;
  late SearchBarResultBehavior _resultBehavior;
  double _unfocusedSliderValue = 0.0;
  double _focusedSliderValue = 0.0;
  double _alwaysSliderValue = 0.0;
  bool _stretch = false;
  bool _largeTitleEnabled = false;
  bool _searchBarEnabled = false;

  @override
  void initState() {
    super.initState();
    _scrollBehavior = widget.scrollBehavior;
    _animationBehavior = widget.animationBehavior;
    _unfocusedSliderValue = widget.unfocusedSliderValue;
    _focusedSliderValue = widget.focusedSliderValue;
    _alwaysSliderValue = widget.alwaysSliderValue;
    _largeTitleEnabled = widget.largeTitleEnabled;
    _searchBarEnabled = widget.searchBarEnabled;
    _stretch = widget.stretch;
    _resultBehavior = widget.resultBehavior;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Text(
                  "Settings",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                GestureDetector(
                  child: const Icon(Icons.cancel),
                  onTap: () => Navigator.of(context).pop([
                    _scrollBehavior,
                    _animationBehavior,
                    _unfocusedSliderValue,
                    _focusedSliderValue,
                    _alwaysSliderValue,
                    _largeTitleEnabled,
                    _searchBarEnabled,
                    _stretch,
                    _resultBehavior,
                  ]),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  "Search Bar",
                  style: TextStyle(fontSize: 14),
                ),
                const Spacer(),
                SizedBox(
                  width: 175,
                  child: CupertinoSlidingSegmentedControl<bool>(
                    backgroundColor: CupertinoColors.systemGrey2,
                    thumbColor: CupertinoColors.systemBlue,
                    // This represents the currently selected segmented control.
                    groupValue: _searchBarEnabled,
                    // Callback that sets the selected segmented control.
                    onValueChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          _searchBarEnabled = value;
                        });
                      }
                    },
                    children: const <bool, Widget>{
                      true: Text(
                        'Enabled',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                      false: Text(
                        'Disabled',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  "Large Title",
                  style: TextStyle(fontSize: 14),
                ),
                const Spacer(),
                SizedBox(
                  width: 175,
                  child: CupertinoSlidingSegmentedControl<bool>(
                    backgroundColor: CupertinoColors.systemGrey2,
                    thumbColor: CupertinoColors.systemBlue,
                    // This represents the currently selected segmented control.
                    groupValue: _largeTitleEnabled,
                    // Callback that sets the selected segmented control.
                    onValueChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          _largeTitleEnabled = value;
                        });
                      }
                    },
                    children: const <bool, Widget>{
                      true: Text(
                        'Enabled',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                      false: Text(
                        'Disabled',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  "Stretch",
                  style: TextStyle(fontSize: 14),
                ),
                const Spacer(),
                SizedBox(
                  width: 175,
                  child: CupertinoSlidingSegmentedControl<bool>(
                    backgroundColor: CupertinoColors.systemGrey2,
                    thumbColor: CupertinoColors.systemBlue,
                    // This represents the currently selected segmented control.
                    groupValue: _stretch,
                    // Callback that sets the selected segmented control.
                    onValueChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          _stretch = value;
                        });
                      }
                    },
                    children: const <bool, Widget>{
                      true: Text(
                        'Enabled',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                      false: Text(
                        'Disabled',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Search Bar Attributes",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  "Scroll Behavior",
                  style: TextStyle(fontSize: 14),
                ),
                const Spacer(),
                SizedBox(
                  width: 175,
                  child:
                      CupertinoSlidingSegmentedControl<SearchBarScrollBehavior>(
                    backgroundColor: CupertinoColors.systemGrey2,
                    thumbColor: CupertinoColors.systemBlue,
                    // This represents the currently selected segmented control.
                    groupValue: _scrollBehavior,
                    // Callback that sets the selected segmented control.
                    onValueChanged: (SearchBarScrollBehavior? value) {
                      if (value != null) {
                        setState(() {
                          _scrollBehavior = value;
                        });
                      }
                    },
                    children: const <SearchBarScrollBehavior, Widget>{
                      SearchBarScrollBehavior.pinned: Text(
                        'Pinned',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                      SearchBarScrollBehavior.floated: Text(
                        'Floated',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  "Animation Behavior",
                  style: TextStyle(fontSize: 14),
                ),
                const Spacer(),
                SizedBox(
                  width: 175,
                  child: CupertinoSlidingSegmentedControl<
                      SearchBarAnimationBehavior>(
                    backgroundColor: CupertinoColors.systemGrey2,
                    thumbColor: CupertinoColors.systemBlue,
                    // This represents the currently selected segmented control.
                    groupValue: _animationBehavior,
                    // Callback that sets the selected segmented control.
                    onValueChanged: (SearchBarAnimationBehavior? value) {
                      if (value != null) {
                        setState(() {
                          _animationBehavior = value;
                        });
                      }
                    },
                    children: const <SearchBarAnimationBehavior, Widget>{
                      SearchBarAnimationBehavior.top: Text(
                        'Top',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                      SearchBarAnimationBehavior.steady: Text(
                        'Steady',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  "Search Result",
                  style: TextStyle(fontSize: 14),
                ),
                const Spacer(),
                SizedBox(
                  width: 250,
                  child:
                      CupertinoSlidingSegmentedControl<SearchBarResultBehavior>(
                    backgroundColor: CupertinoColors.systemGrey2,
                    thumbColor: CupertinoColors.systemBlue,
                    // This represents the currently selected segmented control.
                    groupValue: _resultBehavior,
                    // Callback that sets the selected segmented control.
                    onValueChanged: (SearchBarResultBehavior? value) {
                      if (value != null) {
                        setState(() {
                          _resultBehavior = value;
                        });
                      }
                    },
                    children: const <SearchBarResultBehavior, Widget>{
                      SearchBarResultBehavior.visibleOnFocus: Text(
                        'OnFocus',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                      SearchBarResultBehavior.visibleOnInput: Text(
                        'OnInput',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                      SearchBarResultBehavior.neverVisible: Text(
                        'Never',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Search Action (Visible On)",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  "UnFocused",
                  style: TextStyle(fontSize: 14),
                ),
                const Spacer(),
                CupertinoSlider(
                  key: const Key('slider1'),
                  value: _unfocusedSliderValue,
                  divisions: 3,
                  max: 3,
                  activeColor: CupertinoColors.systemBlue,
                  thumbColor: CupertinoColors.systemBlue,
                  onChanged: (double value) {
                    setState(() {
                      _unfocusedSliderValue = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  "Focused",
                  style: TextStyle(fontSize: 14),
                ),
                const Spacer(),
                CupertinoSlider(
                  key: const Key('slider2'),
                  value: _focusedSliderValue,
                  divisions: 3,
                  max: 3,
                  activeColor: CupertinoColors.systemBlue,
                  thumbColor: CupertinoColors.systemBlue,
                  onChanged: (double value) {
                    setState(() {
                      _focusedSliderValue = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  "Always",
                  style: TextStyle(fontSize: 14),
                ),
                const Spacer(),
                CupertinoSlider(
                  key: const Key('slider3'),
                  value: _alwaysSliderValue,
                  divisions: 3,
                  max: 3,
                  activeColor: CupertinoColors.systemBlue,
                  thumbColor: CupertinoColors.systemBlue,
                  onChanged: (double value) {
                    setState(() {
                      _alwaysSliderValue = value;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
