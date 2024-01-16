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

  bool showDummy = false;

  void setClosed() => setState(() {
        showDummy = false;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SuperScaffold(
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
            onChanged: (text) {
              setState(() {
                if (text.length >= 3) {
                  showDummy = true;
                } else {
                  showDummy = false;
                }
              });
            },
            searchResult: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "This search field has no search action. This is just show off 😎",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "But you can place here any widget conditionally! For example;",
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Write 3 chars to search field",
                    textAlign: TextAlign.center,
                  ),
                ),
                AnimatedCrossFade(
                  firstChild: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      "This can be placeholder",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  secondChild: General.instance.dummyContact(),
                  crossFadeState: showDummy
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 250),
                ),
              ],
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
              CupertinoButton(
                minSize: 0,
                onPressed: () => print,
                padding: EdgeInsets.zero,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.person_crop_circle,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                color: Theme.of(context).cardColor,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed("/play"),
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                General.instance.examples[i].title,
                                style: const TextStyle(fontSize: 18),
                              ),
                              if (General.instance.examples[i].subtitle != null)
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      General.instance.examples[i].subtitle!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: CupertinoColors.systemBlue,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
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
      ),
    );
  }
}
