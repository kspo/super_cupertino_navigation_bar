import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../general.dart';
import '../models/user_list.model.dart';

class AppleMessagesScreen extends StatefulWidget {
  const AppleMessagesScreen({super.key});

  @override
  State<AppleMessagesScreen> createState() => _AppleMessagesScreenState();
}

class _AppleMessagesScreenState extends State<AppleMessagesScreen> {
  ScrollController scrollController = ScrollController();
  final alphabets =
      List.generate(26, (index) => String.fromCharCode(index + 65));

  final List<Users> _users = [];
  bool focused = false;
  bool hasData = false;

  Widget createResultList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          Text("${_users[index].firstName} ${_users[index].lastName}"),
      separatorBuilder: (context, index) => Divider(
        color: CupertinoColors.systemGrey.withOpacity(0.35),
        height: 25,
      ),
      itemCount: _users.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final general = General.instance;
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          SuperCupertinoNavigationBar(
            scrollController: scrollController,
            largeTitle: const Text("Messages"),
            appBarType: AppBarType.LargeTitleWithFloatedSearch,
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(CupertinoIcons.pencil_ellipsis_rectangle)],
            ),
            leading: GestureDetector(
              onTap: null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "Edit",
                  style: general.getLinkStyle(context).copyWith(fontSize: 18),
                ),
              ),
            ),
            searchFieldDecoration: SearchFieldDecoration(
              placeholderText: "Search",
              searchFieldBehaviour:
                  SearchFieldBehaviour.ShowResultScreenAfterFieldFocused,
              onFocused: (value) => setState(() {
                focused = value;
              }),
              onSuffixTap: () {
                setState(() {
                  hasData = false;
                });
              },
              onCancelTap: () {
                setState(() {
                  hasData = false;
                });
              },
              onChanged: (text1) {
                setState(() {
                  hasData = text1.isNotEmpty;
                });
              },
              onSubmitted: (text1) {
                setState(() {
                  hasData = text1.isNotEmpty;
                });
              },
              searchResultChildren: !hasData
                  ? []
                  : [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          for (int i = 0; i < 4; i++)
                            Expanded(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(700),
                                    child: Image.asset(
                                      "assets/empty_profile.png",
                                      width: 55,
                                      height: 55,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "John Doe",
                                    style: TextStyle(fontSize: 14),
                                  )
                                ],
                              ),
                            )
                        ],
                      ),
                      Divider(
                        indent: 15,
                        endIndent: 15,
                        color: Colors.grey.withOpacity(0.25),
                        height: 40,
                      ),
                      ListView.separated(
                        itemCount: 4,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        separatorBuilder: (c, i) => Divider(
                          color: Colors.grey.withOpacity(0.25),
                          height: 20,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (c, i) => const Row(
                          children: [
                            Icon(
                              CupertinoIcons.profile_circled,
                              size: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Messages with: Lorem Ipsum...")
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.25),
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Text(
                              "Fotoğraflar",
                              style: general.getSubtitle(context),
                            ),
                            const Spacer(),
                            Text(
                              "Tümünü Gör",
                              style: general.getLinkStyle(context),
                            )
                          ],
                        ),
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: List.generate(100, (index) {
                          return Container(
                            color: general.colors[index % 7],
                            child: Text(
                              'Item $index',
                            ),
                          );
                        }),
                      )
                    ],
            ),
            previousPageTitle: "Lists",
            stretch: true,
            slivers: [
              SliverFillRemaining(
                child: FutureBuilder(
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Users>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        separatorBuilder: (context, index) => Divider(
                          color: CupertinoColors.systemGrey.withOpacity(0.35),
                          height: 25,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              index < 3
                                  ? Container(
                                      height: 10,
                                      width: 10,
                                      margin: const EdgeInsets.only(top: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: CupertinoColors.systemBlue,
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    snapshot.data![index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${snapshot.data![index].firstName} ${snapshot.data![index].lastName}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const Spacer(),
                                        const Opacity(
                                          opacity: 0.5,
                                          child: Text(
                                            "12:21",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Opacity(
                                      opacity: 0.5,
                                      child: Text(
                                        "${snapshot.data![index].university} ${snapshot.data![index].company?.title}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      return const CupertinoActivityIndicator(
                        radius: 13,
                      );
                    }
                  },
                  future: general.getUsers(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
