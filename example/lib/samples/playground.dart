import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../settings_widget.dart';

class Playground extends StatefulWidget {
  const Playground({super.key});

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  SearchBarScrollBehavior scrollBehavior = SearchBarScrollBehavior.pinned;
  SearchBarAnimationBehavior animationBehavior = SearchBarAnimationBehavior.top;
  double unfocusedSliderValue = 1.0;
  double focusedSliderValue = 0.0;
  double alwaysSliderValue = 0.0;
  bool stretch = true;
  bool largeTitleEnabled = false;
  bool searchBarEnabled = false;
  SearchBarResultBehavior resultBehavior =
      SearchBarResultBehavior.visibleOnFocus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: CupertinoColors.systemBlue,
        onPressed: () async {
          dynamic value = await showCupertinoModalBottomSheet(
            expand: true,
            context: context,
            enableDrag: false,
            builder: (context) => SettingsWidget(
              scrollBehavior: scrollBehavior,
              animationBehavior: animationBehavior,
              unfocusedSliderValue: unfocusedSliderValue,
              focusedSliderValue: focusedSliderValue,
              alwaysSliderValue: alwaysSliderValue,
              largeTitleEnabled: largeTitleEnabled,
              searchBarEnabled: searchBarEnabled,
              stretch: stretch,
              resultBehavior: resultBehavior,
            ),
          );
          setState(() {
            scrollBehavior = value[0];
            animationBehavior = value[1];
            unfocusedSliderValue = value[2];
            focusedSliderValue = value[3];
            alwaysSliderValue = value[4];
            largeTitleEnabled = value[5];
            searchBarEnabled = value[6];
            stretch = value[7];
            resultBehavior = value[8];
          });
        },
        child: const Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ),
      body: SuperScaffold(
        onCollapsed: (val) {
          print("collapsed => $val");
        },
        stretch: stretch,
        appBar: SuperAppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Wanna Play?",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
          previousPageTitle: "Home",
          actions: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                CupertinoIcons.camera,
                color: CupertinoColors.systemBlue,
                size: 27,
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  print("go anywhere");
                  //Navigator.pushNamed(context, "/second");
                },
                child: Center(
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemBlue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Icon(
                        CupertinoIcons.add,
                        color: CupertinoColors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 13,
              ),
            ],
          ),
          searchBar: SuperSearchBar(
            // height: 190,
            enabled: searchBarEnabled,
            searchResult: const Text(
              "This is result page",
              style: TextStyle(color: Colors.white),
            ),
            animationBehavior: animationBehavior,
            resultColor: Theme.of(context).appBarTheme.backgroundColor,
            resultBehavior: resultBehavior,
            scrollBehavior: scrollBehavior,
            cancelButtonText: "Cancel",
            actions: [
              ...List.generate(
                  unfocusedSliderValue.toInt(),
                  (index) => const SuperAction(
                        behavior: SuperActionBehavior.visibleOnUnFocus,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(
                            Icons.filter_list,
                            color: CupertinoColors.systemBlue,
                            size: 25,
                          ),
                        ),
                      )).toList(),
              ...List.generate(
                  focusedSliderValue.toInt(),
                  (index) => const SuperAction(
                        behavior: SuperActionBehavior.visibleOnFocus,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(
                            Icons.filter_list,
                            color: CupertinoColors.systemBlue,
                            size: 25,
                          ),
                        ),
                      )).toList(),
              ...List.generate(
                  alwaysSliderValue.toInt(),
                  (index) => const SuperAction(
                        behavior: SuperActionBehavior.alwaysVisible,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(
                            Icons.filter_list,
                            color: CupertinoColors.systemBlue,
                            size: 25,
                          ),
                        ),
                      )).toList(),
            ],
          ),
          largeTitle: SuperLargeTitle(
            // height: 0,
            enabled: largeTitleEnabled,
            largeTitle: "Playground",
          ),
        ),
        body: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (c, i) => Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      Text("$i"),
                    ],
                  ),
                ),
            separatorBuilder: (c, i) => const Divider(),
            itemCount: 100),
      ),
    );
  }
}
