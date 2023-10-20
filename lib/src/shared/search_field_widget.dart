import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/src/shared/measures.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
    required this.searchFieldDecoration,
    required this.opacityRate,
    required this.animationController,
    required this.focusNode,
    required this.textEditingController,
    required this.searchKey,
    required this.hasFocusValueNotifier,
    required this.hasDataValueNotifier,
    this.largeTitleType = AppBarType.LargeTitleWithFloatedSearch,
  });

  final SearchFieldDecoration searchFieldDecoration;
  final double opacityRate;
  final AnimationController animationController;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final Key searchKey;
  final ValueNotifier<bool> hasFocusValueNotifier;
  final ValueNotifier<bool> hasDataValueNotifier;
  final AppBarType largeTitleType;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  double? cancelButtonWidth;
  final _cancelButtonKey = GlobalKey();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_cancelButtonKey.currentContext != null) {
        cancelButtonWidth = _cancelButtonKey.currentContext
            ?.findRenderObject()
            ?.paintBounds
            .size
            .width;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: widget.hasFocusValueNotifier.value
              ? (cancelButtonWidth == null
                  ? MediaQuery.of(context).size.width * 0.725
                  : MediaQuery.of(context).size.width -
                      (cancelButtonWidth! +
                          widget.searchFieldDecoration.paddingLeft +
                          2 * widget.searchFieldDecoration.paddingRight))
              : MediaQuery.of(context).size.width,
          child: Focus(
            onFocusChange: (value) {
              if (value) {
                widget.hasFocusValueNotifier.value = true;
                widget.animationController.forward();
              }
              widget.searchFieldDecoration.onFocused?.call(value);
            },
            child: SizedBox.expand(
              child: TextSelectionTheme(
                data: TextSelectionThemeData(
                    cursorColor: widget.searchFieldDecoration.cursorColor),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: KeyedSubtree(
                        key: widget.searchKey,
                        child: Container(
                          decoration: widget.searchFieldDecoration.decoration ??
                              BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: CupertinoColors.systemGrey
                                    .withOpacity(0.25),
                              ),
                          child: Opacity(
                            opacity: widget.largeTitleType ==
                                    AppBarType.LargeTitleWithFloatedSearch
                                ? widget.opacityRate
                                : 1,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 6,
                                  bottom: 0,
                                  height: Measures.searchBarHeight - 2,
                                  child:
                                      widget.searchFieldDecoration.prefixIcon ??
                                          Icon(
                                            CupertinoIcons.search,
                                            color: widget.searchFieldDecoration
                                                    .prefixIconColor ??
                                                CupertinoColors.systemGrey,
                                            size: 22,
                                            fill: 1,
                                          ),
                                ),
                                Positioned(
                                  left: 38,
                                  bottom: 0,
                                  child: ValueListenableBuilder(
                                    valueListenable:
                                        widget.hasDataValueNotifier,
                                    builder:
                                        (context, searchBarHasData, child) {
                                      return searchBarHasData
                                          ? const SizedBox()
                                          : Text(
                                              widget.searchFieldDecoration
                                                      .placeholderText ??
                                                  "Search",
                                              style: TextStyle(
                                                height: 3.7,
                                                color: widget
                                                        .searchFieldDecoration
                                                        .placeholderColor ??
                                                    CupertinoColors.systemGrey,
                                              ),
                                            );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    CupertinoSearchTextField(
                      onSuffixTap: () {
                        widget.textEditingController.text = "";
                        widget.hasDataValueNotifier.value = false;
                        widget.searchFieldDecoration.onSuffixTap?.call();
                      },
                      suffixIcon: widget.searchFieldDecoration.suffixIcon,
                      focusNode: widget.focusNode,
                      autocorrect: false,
                      // style: widget.searchFieldDecoration.style,
                      controller: widget.textEditingController,
                      onChanged: (text) {
                        if (text.isNotEmpty) {
                          widget.hasDataValueNotifier.value = true;
                        } else {
                          widget.hasDataValueNotifier.value = false;
                        }
                        widget.searchFieldDecoration.onChanged?.call(text);
                      },
                      // backgroundColor: widget.searchFieldDecoration.backgroundColor,
                      onSubmitted: widget.searchFieldDecoration.onSubmitted,
                      placeholder: "",
                      /*placeholderStyle:
                          (widget.searchFieldDecoration.placeholderStyle ??
                              const TextStyle(color: CupertinoColors.systemGrey)
                                  .copyWith(
                                      color: (widget.searchFieldDecoration
                                                  .placeholderStyle?.color ??
                                              CupertinoColors.systemGrey)
                                          .withOpacity(widget._opacityRate))),*/
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      // borderRadius: widget.searchFieldDecoration.borderRadius,
                      keyboardType: widget.searchFieldDecoration.keyboardType,
                      padding: widget.searchFieldDecoration.padding
                          .add(const EdgeInsets.only(left: 25)),
                      // itemSize: widget.searchFieldDecoration.itemSize,
                      prefixIcon: const SizedBox(),
                      suffixInsets: widget.searchFieldDecoration.suffixInsets,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: AnimatedOpacity(
            curve: Curves.easeIn,
            duration: Measures.navBarCollapseDuration,
            opacity: widget.hasFocusValueNotifier.value ? 1 : 0,
            child: AnimatedSlide(
              offset: Offset(widget.hasFocusValueNotifier.value ? 0 : 2, 0),
              duration: const Duration(milliseconds: 250),
              child: GestureDetector(
                onTap: () async {
                  widget.searchFieldDecoration.onCancelTap?.call();
                  widget.hasDataValueNotifier.value = false;
                  await cancelSearch(
                    widget.textEditingController,
                    widget.focusNode,
                  );

                  widget.animationController.reverse();
                },
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Text(
                      key: _cancelButtonKey,
                      widget.searchFieldDecoration.cancelButtonName,
                      textAlign: TextAlign.center,
                      style: widget.searchFieldDecoration.cancelButtonStyle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future cancelSearch(
      TextEditingController textController, FocusNode searchFocus) async {
    textController.text = "";
    searchFocus.unfocus();
    widget.hasFocusValueNotifier.value = false;
  }
}
