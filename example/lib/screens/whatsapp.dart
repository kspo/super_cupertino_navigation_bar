import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

import '../general.dart';
import '../models/user_list.model.dart';

class WhatsAppScreen extends StatefulWidget {
  const WhatsAppScreen({super.key});

  @override
  State<WhatsAppScreen> createState() => _WhatsAppScreenState();
}

class _WhatsAppScreenState extends State<WhatsAppScreen> {
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
            largeTitle: const Text("Chats"),
            appBarType: AppBarType.LargeTitleWithFloatedSearch,
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.camera,
                  size: 25,
                ),
                SizedBox(
                  width: 25,
                ),
                Icon(
                  CupertinoIcons.pencil_circle,
                  size: 25,
                )
              ],
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
              actionButtons: [
                SearchBarActionButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () => showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => Container(
                      width: double.infinity,
                      color: CupertinoColors.white,
                      height: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/heisenberg.jpeg",
                            width: 250,
                          ),
                          const Text("I'm not in a danger, Skylar!"),
                          const Text(
                            "I'm the danger!",
                            style: TextStyle(
                              color: CupertinoColors.destructiveRed,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actionButtonsBehaviour:
                      SearchFieldActionButtonsBehaviour.VisibleOnUnFocus,
                )
              ],
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
                  ? [
                      ListView.separated(
                        itemCount: general.watssapp.length,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        separatorBuilder: (c, i) => Divider(
                          color: Colors.grey.withOpacity(0.25),
                          height: 20,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (c, i) => Row(
                          children: [
                            Icon(general.watssapp[i].iconData),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(general.watssapp[i].title),
                            const Spacer(),
                            const Icon(
                              CupertinoIcons.arrow_up_left_circle,
                              size: 17,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ]
                  : [
                      const SizedBox(
                        height: 15,
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
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: const EdgeInsets.all(2.5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  child: SizedBox(
                                    height: 55,
                                    width: 55,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        snapshot.data![index].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
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
                                        Opacity(
                                          opacity: index == 1 ? 1 : 0.5,
                                          child: Text(
                                            "12:21",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: index == 1
                                                    ? Colors.blue
                                                    : Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Opacity(
                                            opacity: 0.5,
                                            child: Text(
                                              "${snapshot.data![index].university} ${snapshot.data![index].company?.title}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: false,
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 35,
                                        ),
                                        index == 1
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                width: 17,
                                                height: 17,
                                                child: const Center(
                                                  child: Text(
                                                    "1",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
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
