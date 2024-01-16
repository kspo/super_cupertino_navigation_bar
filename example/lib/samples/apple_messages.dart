import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
import 'package:untitled/models/user_list.dart';
import 'package:untitled/utils/general.dart';

class AppleMessages extends StatefulWidget {
  const AppleMessages({super.key});

  @override
  State<AppleMessages> createState() => _AppleMessagesState();
}

class _AppleMessagesState extends State<AppleMessages> {
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SuperScaffold(
        appBar: SuperAppBar(
          backgroundColor: Colors.black.withOpacity(0.5),
          leadingWidth: 100,
          title: Text(
            "Messages",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
          actions: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.pencil_ellipsis_rectangle,
                color: CupertinoColors.systemBlue,
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          leading: GestureDetector(
            onTap: null,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 19),
              child: Text(
                "Edit",
                style: General.instance
                    .getLinkStyle(context)
                    .copyWith(fontSize: 18),
              ),
            ),
          ),
          searchBar: SuperSearchBar(
            resultColor: Colors.black,
            scrollBehavior: SearchBarScrollBehavior.pinned,
            resultBehavior: SearchBarResultBehavior.visibleOnFocus,
            onFocused: (value) => setState(() {
              focused = value;
              if (!value) {
                hasData = false;
              }
            }),
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
            searchResult: SingleChildScrollView(
              child: !hasData
                  ? const Column(children: [])
                  : Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        General.instance.dummyContact(),
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
                                style: General.instance.getSubtitle(context),
                              ),
                              const Spacer(),
                              Text(
                                "Tümünü Gör",
                                style: General.instance.getLinkStyle(context),
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
                              color: General.instance.colors[index % 7],
                              child: Text(
                                'Item $index',
                              ),
                            );
                          }),
                        )
                      ],
                    ),
            ),
          ),
          largeTitle: SuperLargeTitle(
            largeTitle: "Messages",
          ),
        ),
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<List<Users>> snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                separatorBuilder: (context, index) => Divider(
                  color: CupertinoColors.systemGrey.withOpacity(0.35),
                  height: 25,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      index < 3
                          ? Container(
                              height: 10,
                              width: 10,
                              margin: const EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: CupertinoColors.systemBlue,
                              ),
                            )
                          : const SizedBox(
                              height: 10,
                              width: 10,
                            ),
                      const SizedBox(
                        width: 8,
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
          future: General.instance.getUsers(),
        ),
      ),
    );
  }
}
