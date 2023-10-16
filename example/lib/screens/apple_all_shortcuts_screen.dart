import 'package:example/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class AppleAllShortcutsScreen extends StatefulWidget {
  const AppleAllShortcutsScreen({super.key});

  @override
  State<AppleAllShortcutsScreen> createState() =>
      _AppleAllShortcutsScreenState();
}

class _AppleAllShortcutsScreenState extends State<AppleAllShortcutsScreen> {
  final _general = General.instance;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SuperCupertinoNavigationBar(
        largeTitle: const Text("All Shortcuts"),
        previousPageTitle: "Home",
        searchFieldDecoration: SearchFieldDecoration(
          searchFieldBehaviour: SearchFieldBehaviour.NeverShowResultScreen,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _general.showSnackBar(context),
              child: const Text("Edit"),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _general.showSnackBar(context),
              child: Icon(
                CupertinoIcons.add,
                color: CupertinoTheme.of(context).primaryColor,
                size: 25,
              ),
            ),
          ],
        ),
        stretch: true,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
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
                    style: _general.getSubtitle(context),
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
          ),
          SliverToBoxAdapter(
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(
                color: CupertinoColors.darkBackgroundGray,
              ),
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              itemBuilder: (c, index) => SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _general.colors[index],
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
                                    CupertinoIcons.arrow_up_right_circle_fill,
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
                          color: _general.colors[index + 2],
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
                                    CupertinoIcons.arrow_up_right_circle_fill,
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
          ),
          SliverList.builder(
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
                        style: _general.getSubtitle(context),
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
                        _general.colors[i % 6],
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
          ),
        ],
      ),
    );
  }
}
