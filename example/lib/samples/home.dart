import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
import 'package:untitled/utils/general.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SearchBarScrollBehavior scrollBehavior = SearchBarScrollBehavior.floated;
  SearchBarAnimationBehavior animationBehavior = SearchBarAnimationBehavior.top;
  double unfocusedSliderValue = 1.0;
  double focusedSliderValue = 0.0;
  double alwaysSliderValue = 0.0;
  bool stretch = true;
  bool largeTitleEnabled = true;
  bool searchBarEnabled = true;
  SearchBarResultBehavior resultBehavior =
      SearchBarResultBehavior.visibleOnFocus;

  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      onCollapsed: (val) {
        print("collapsed => $val");
      },
      transitionBetweenRoutes: true,
      stretch: stretch,
      appBar: SuperAppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Welcome",
          style:
              TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
        ),
        searchBar: SuperSearchBar(
          resultColor: Theme.of(context).appBarTheme.backgroundColor,
          enabled: searchBarEnabled,
          searchResult: const Text(
            "This is result page",
            style: TextStyle(color: Colors.white),
          ),
          animationBehavior: animationBehavior,
          resultBehavior: resultBehavior,
          scrollBehavior: scrollBehavior,
          cancelButtonText: "Cancel",
        ),
        largeTitle: SuperLargeTitle(
          enabled: largeTitleEnabled,
          largeTitle: "Welcome",
          actions: [
            const Icon(
              CupertinoIcons.profile_circled,
              size: 30,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Theme.of(context).cardColor,
              margin: const EdgeInsets.all(15),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed("/play"),
                child: Container(
                  color: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          "assets/heisenberg.jpeg",
                          width: 35,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Playground",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      const Icon(
                        CupertinoIcons.arrow_right,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              color: Theme.of(context).cardColor,
              margin: const EdgeInsets.all(15),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (c, i) => GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(General.instance.examples[i].screen),
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            "${General.instance.examples[i].imageUrl}",
                            width: 35,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          General.instance.examples[i].title,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const Spacer(),
                        const Icon(
                          CupertinoIcons.arrow_right,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (c, i) => const Divider(
                  indent: 65,
                  height: 0,
                ),
                itemCount: General.instance.examples.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
