

import 'package:flutter/material.dart';

import '../../core/theme/app_icon.dart';
import '../../domain/entities/feed_entities.dart';

class MockFeedItem {

  static final List<FeedEntities> feedItems = [
    FeedEntities(
      userName: "Cún",
      pathAvatar: AppIcon.avatar,
      actionText: "đã chia sẻ một câu",
      timeAgo: "13 tiếng",
      content: "a big potato",
      contentType: FeedContentType.textCard,
      pathIcon: AppIcon.feedHuman,
      likeCount: 302,
      commentCount: 1,
      isLiked: false,
      likedByNames: ["Nguyễn", "Trần", "Lê"],
      isFriend: true,
    ),
    FeedEntities(
      userName: "Phương Nam",
      timeAgo: "1 tiếng",
      pathAvatar: AppIcon.avatar,

      content: "Đã cán mốc chuỗi 400 ngày streak!",
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedStreakSelf,

      likeCount: 4,
      isLiked: true, // Đã tim
      likedByNames: ["T Nguyên<3"],
      isFriend: true,
    ),
    FeedEntities(
      userName: "Chang Chang",
      pathAvatar: AppIcon.avatar,

      timeAgo: "3 tiếng",
      content: "Đã nói được tổng cộng 2300 từ tiếng Trung!",
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedSpeak,

      likeCount: 0,
      isLiked: false,
      likedByNames: [],
      isFriend: true,
    ),
  ];
}