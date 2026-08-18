import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/widgets/app_header.dart';
import 'package:duolingo_ui_clone/data/mock_data/mock_feed_item.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/feed_entities.dart';
import '../widgets/feed_item_widget.dart';

class NewsFeedScreen extends StatefulWidget {

  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() {
    return NewsFeedScreenState();
  }
}

class NewsFeedScreenState extends State<NewsFeedScreen> {
  // mock du lieu
  final feedItems = MockFeedItem.feedItems;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ListView.builder tương đương RecyclerView trong Android
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              child: Row(
                children: [
                  Text(
                    'Bảng tin',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF3C3C3C),
                    ),
                  ),
                ],
              ),
              scrollController: _scrollController,
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: feedItems.length,
                itemBuilder: (context, index) {
                  return FeedItemWidget(item: feedItems[index]);
                },
              ),
            ),
          ],
        )
      )
    );
  }
}
