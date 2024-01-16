import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
import 'package:untitled/utils/general.dart';

class AppleAllShortcuts extends StatefulWidget {
  const AppleAllShortcuts({super.key});

  @override
  State<AppleAllShortcuts> createState() => _AppleAllShortcutsState();
}

class _AppleAllShortcutsState extends State<AppleAllShortcuts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SuperScaffold(
          appBar: SuperAppBar(
            backgroundColor: Colors.black.withOpacity(0.5),
            leadingWidth: 100,
            previousPageTitle: "Home",
            title: Text(
              "All Shortcuts",
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            actions: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => General.instance.showSnackBar(context),
                  child: const Text("Edit"),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => General.instance.showSnackBar(context),
                  child: Icon(
                    CupertinoIcons.add,
                    color: CupertinoTheme.of(context).primaryColor,
                    size: 25,
                  ),
                ),
              ],
            ),
            searchBar: SuperSearchBar(
              resultColor: Colors.black,
              scrollBehavior: SearchBarScrollBehavior.floated,
              resultBehavior: SearchBarResultBehavior.neverVisible,
              animationBehavior: SearchBarAnimationBehavior.steady,
            ),
            largeTitle: SuperLargeTitle(
              largeTitle: "All Shortcuts",
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 10.0, bottom: 15),
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.folder),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Starter Shortcuts",
                        style: General.instance.getSubtitle(context),
                      ),
                      const Icon(
                        CupertinoIcons.chevron_forward,
                        color: CupertinoColors.systemGrey,
                      ),
                      const Spacer(),
                      const Icon(CupertinoIcons.add),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(
                    color: CupertinoColors.darkBackgroundGray,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  itemBuilder: (c, index) => SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: General.instance.colors[index],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(right: 15),
                            child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.square_stack_fill,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      Spacer(),
                                      Icon(
                                        CupertinoIcons
                                            .arrow_up_right_circle_fill,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    "Just Square",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: General.instance.colors[index + 2],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(right: 15),
                            child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.square_stack_fill,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      Spacer(),
                                      Icon(
                                        CupertinoIcons
                                            .arrow_up_right_circle_fill,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    "Just Square",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  itemCount: 2,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (c, i) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 45.0, bottom: 15),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                "assets/app_icon_$i.png",
                                width: 25,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Apple Apps",
                              style: General.instance.getSubtitle(context),
                            ),
                            const Icon(
                              CupertinoIcons.chevron_forward,
                              color: CupertinoColors.systemGrey,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            // Where the linear gradient begins and ends
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0, 0.6],
                            colors: [
                              Colors.white.withOpacity(0.9),
                              General.instance.colors[i % 6],
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: const Icon(
                                        CupertinoIcons.photo_on_rectangle,
                                        color: CupertinoColors.white,
                                        size: 35,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Photos",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.6),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: const Icon(
                                        CupertinoIcons.photo_on_rectangle,
                                        color: CupertinoColors.white,
                                        size: 35,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Photos",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.6),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: const Icon(
                                        CupertinoIcons.photo_on_rectangle,
                                        color: CupertinoColors.white,
                                        size: 35,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Photos",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.6),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: const Icon(
                                        CupertinoIcons.photo_on_rectangle,
                                        color: CupertinoColors.white,
                                        size: 35,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Photos",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.6),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  itemCount: 15,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          )),
    );
  }
}
