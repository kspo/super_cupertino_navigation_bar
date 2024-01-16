import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';
import 'package:untitled/models/user_list.dart';
import 'package:untitled/utils/general.dart';

class Whatsapp extends StatefulWidget {
  const Whatsapp({super.key});

  @override
  State<Whatsapp> createState() => _WhatsappState();
}

class _WhatsappState extends State<Whatsapp> {
  bool hasData = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff050505),
      body: SuperScaffold(
        onCollapsed: (val) {
          print("collapsed => $val");
        },
        stretch: true,
        appBar: SuperAppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: true,
          title: Text(
            "Whatsapp",
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
          ),
          leading: const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Icon(
              CupertinoIcons.ellipsis_circle,
              color: CupertinoColors.systemBlue,
              size: 27,
            ),
          ),
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
                  // Navigator.pushNamed(context, "/second");
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
          largeTitle: SuperLargeTitle(
            // height: 0,
            largeTitle: "Whatsapp",
          ),
          searchBar: SuperSearchBar(
            resultColor: Colors.black,
            onFocused: (value) => setState(() {
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
            searchResult: hasData
                ? ListView.separated(
                    itemCount: General.instance.watssapp.length,
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
                        Icon(General.instance.watssapp[i].iconData),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(General.instance.watssapp[i].title),
                        const Spacer(),
                        const Icon(
                          CupertinoIcons.arrow_up_left_circle,
                          size: 17,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  )
                : ListView.separated(
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
            animationBehavior: SearchBarAnimationBehavior.top,
            resultBehavior: SearchBarResultBehavior.visibleOnFocus,
            scrollBehavior: SearchBarScrollBehavior.floated,
            cancelButtonText: "Cancel",
            actions: [
              const SuperAction(
                behavior: SuperActionBehavior.visibleOnUnFocus,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Icon(
                    Icons.filter_list,
                    color: CupertinoColors.systemBlue,
                    size: 25,
                  ),
                ),
              )
            ],
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
                                      style: const TextStyle(fontSize: 15),
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
          future: General.instance.getUsers(),
        ),
      ),
    );
  }
}
