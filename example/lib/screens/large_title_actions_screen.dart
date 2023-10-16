import 'package:example/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class LargeTitleActionsScreen extends StatefulWidget {
  const LargeTitleActionsScreen({super.key});

  @override
  State<LargeTitleActionsScreen> createState() =>
      _LargeTitleActionsScreenState();
}

class _LargeTitleActionsScreenState extends State<LargeTitleActionsScreen> {
  final _general = General.instance;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SuperCupertinoNavigationBar(
        largeTitle: const Text("Get Stuff Done"),
        largeTitleType: AppBarType.LargeTitleWithoutSearch,
        previousPageTitle: "Widgets",
        stretch: true,
        slivers: [
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
                          color: index % 2 == 0
                              ? _general.colors[index % _general.colors.length]
                              : _general.colors.reversed
                                  .toList()[index % _general.colors.length],
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
                    const Expanded(
                      child: Opacity(
                        opacity: 0.75,
                        child: Text(
                          "Start a custom timer and turn on your focus until it's done",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              itemCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
