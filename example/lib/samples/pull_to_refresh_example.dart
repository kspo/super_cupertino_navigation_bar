import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class PullToRefreshExample extends StatefulWidget {
  const PullToRefreshExample({super.key});

  @override
  State<PullToRefreshExample> createState() => _PullToRefreshExampleState();
}

class _PullToRefreshExampleState extends State<PullToRefreshExample> {
  List<String> items = List.generate(20, (index) => 'Item ${index + 1}');
  bool isLoading = false;
  int refreshCount = 0;

  Future<void> _handleRefresh() async {
    if (!mounted) return;
    
    setState(() {
      isLoading = true;
    });

    // Simulate network request
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    
    // Add new items at the beginning
    setState(() {
      refreshCount++;
      items = [
        'New Item ${DateTime.now().millisecondsSinceEpoch}',
        ...items,
      ];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      appBar: SuperAppBar(
        title: const Text('Pull to Refresh'),
        backgroundColor: CupertinoColors.systemBackground,
        largeTitle: SuperLargeTitle(
          largeTitle: 'Pull to Refresh',
          actions: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text('Refresh Stats'),
                    content: Text('You have refreshed $refreshCount times\n${items.length} total items'),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('OK'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(CupertinoIcons.info_circle),
            ),
          ],
        ),
        searchBar: SuperSearchBar(
          enabled: true,
          placeholderText: 'Search items...',
          onChanged: (value) {
            // Implement search functionality
          },
          searchResult: Container(
            color: CupertinoColors.systemBackground,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.search,
                    size: 64,
                    color: CupertinoColors.systemGrey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Search results would appear here',
                    style: TextStyle(
                      color: CupertinoColors.systemGrey.resolveFrom(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // Enable pull-to-refresh with custom settings
      onRefresh: _handleRefresh,
      refreshTriggerPullDistance: 100.0,
      refreshIndicatorExtent: 60.0,
      stretch: true, // Allow the nav bar to stretch
      body: CustomScrollView(
        slivers: [
          // Instructional header
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CupertinoColors.systemBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: CupertinoColors.systemBlue.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.arrow_down_circle,
                        color: CupertinoColors.systemBlue,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Default iOS Refresh',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.label.resolveFrom(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pull down to see the default iOS refresh indicator in action. The standard iOS spinner will appear when you pull down far enough.',
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.secondaryLabel.resolveFrom(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // List of items
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = items[index];
                final isNew = item.startsWith('New Item');
                
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: isNew 
                      ? CupertinoColors.systemGreen.withOpacity(0.1)
                      : CupertinoColors.systemGrey6.resolveFrom(context),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isNew
                        ? CupertinoColors.systemGreen.withOpacity(0.3)
                        : CupertinoColors.separator.resolveFrom(context),
                      width: 1,
                    ),
                  ),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Handle item tap
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: isNew
                              ? CupertinoColors.systemGreen
                              : CupertinoColors.systemBlue,
                            radius: 20,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isNew ? FontWeight.bold : FontWeight.normal,
                                    color: CupertinoColors.label.resolveFrom(context),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  isNew ? 'Just added!' : 'Pull to refresh and add new items',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isNew
                                      ? CupertinoColors.systemGreen
                                      : CupertinoColors.secondaryLabel.resolveFrom(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            isNew ? CupertinoIcons.star_fill : CupertinoIcons.chevron_right,
                            color: isNew
                              ? CupertinoColors.systemYellow
                              : CupertinoColors.tertiaryLabel.resolveFrom(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: items.length,
            ),
          ),
          
          // Add some padding at the bottom
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }
} 