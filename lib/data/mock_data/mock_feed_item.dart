

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icon.dart';
import '../../domain/entities/feed_entities.dart';

class MockFeedItem {

  static final List<FeedEntities> feedItems = [
    FeedEntities(
      userName: "Cún",
      pathAvatar: AppIcon.avatar,
      actionText: "đã chia sẻ một câu",
      timeAgo: "13 tiếng",
      contentType: FeedContentType.textCard,
      pathIcon: AppIcon.feedHuman,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(AppIcon.flagUnitedState,
          width: 24,),
          SizedBox(height: 8,),

          Text('A big potato', style: TextStyle(fontWeight: FontWeight.w600),),
          SizedBox(height: 8,),

          Text('Một củ khoai tây to', style: TextStyle(color: AppColors.textGrayOnBackground),),
        ],
      ),
      likeCount: 302,
      commentCount: 1,
      isLiked: false,
      likedByNames: ["Nguyễn", "Trần", "Lê"],
      isFriend: true,
    ),
    FeedEntities(
        userName: "T Nguyên<3",
        pathAvatar: AppIcon.avatar,
        timeAgo: "3 ngày",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Đã sửa tổng cộng 250 lỗi sai!"),
          ],
        ),
        contentType: FeedContentType.plainText,
        pathIcon: AppIcon.feedFixBug,
        likeCount: 56,
        commentCount: 7,
        isLiked: false,
        likedByNames: ["Jennie", "Lisa"],
        isFriend: true,
        isSelf: true
    ),
    FeedEntities(
      userName: "Phương Nam",
      timeAgo: "1 tiếng",
      pathAvatar: AppIcon.avatar,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đã cán mốc chuỗi 400 ngày streak!"),
        ],
      ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đã nói được tổng cộng 2300 từ tiếng Trung!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedSpeak,

      likeCount: 0,
      isLiked: false,
      likedByNames: [],
      isFriend: true,
    ),
    FeedEntities(
      userName: "Thanh",
      pathAvatar: AppIcon.avatar,
      timeAgo: "2 ngày",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đã sửa tổng cộng 250 lỗi sai!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedFixBug,
      likeCount: 12,
      commentCount: 3,
      isLiked: false,
      likedByNames: ["T Nguyên<3", "Phương"],
      isFriend: true,
    ),
    FeedEntities(
      userName: "Phương",
      pathAvatar: AppIcon.avatar,
      timeAgo: "2 ngày",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đã chạm mốc 3 ngày Streak bạn bè!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedStreakSelf,
      likeCount: 8,
      commentCount: 2,
      isLiked: false,
      likedByNames: ["Lý", "Minh"],
      isFriend: true,
    ),
    FeedEntities(
      userName: "Dora",
      pathAvatar: AppIcon.avatar,
      timeAgo: "15 giờ",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đã đạt chuỗi 300 câu liên hoàn!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feeddungnhieu,
      likeCount: 5,
      commentCount: 1,
      isLiked: false,
      likedByNames: ["User1"],
      isFriend: false,
    ),
    FeedEntities(
      userName: "An thịt con gà xanh lá",
      pathAvatar: AppIcon.avatar,
      timeAgo: "1 ngày",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đã bằng qua một bài học trong vòng chưa đầy 2 phút!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedSpeed,
      likeCount: 3,
      commentCount: 0,
      isLiked: false,
      likedByNames: [],
      isFriend: true,
    ),
    FeedEntities(
      userName: "Quyền",
      pathAvatar: AppIcon.avatar,
      timeAgo: "1 ngày",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đã hoàn thành 3 bài học liên tiếp!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedSpeed,
      likeCount: 7,
      commentCount: 2,
      isLiked: false,
      likedByNames: ["Annie❤️", "Ngọc"],
      isFriend: true,
    ),
    FeedEntities(
      userName: "Annie❤️",
      pathAvatar: AppIcon.avatar,
      timeAgo: "5 ngày",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(AppIcon.flagUnitedState,
            width: 24,),
          SizedBox(height: 8,),

          Text('I like this quiz!', style: TextStyle(fontWeight: FontWeight.w600),),
          SizedBox(height: 8,),

          Text('Tôi thích bài trắc nghiệm này!', style: TextStyle(color: AppColors.textGrayOnBackground),),
        ],
      ),

      contentType: FeedContentType.textCard,
      pathIcon: AppIcon.feedHuman,
      likeCount: 1961,
      commentCount: 45,
      isLiked: true,
      likedByNames: ["Ben1", "Hằng"],
      isFriend: true,
    ),
    FeedEntities(
      userName: "Ngọc Bích",
      pathAvatar: AppIcon.avatar,
      timeAgo: "1 ngày",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đã kiếm được tổng cộng 500 điểm thưởng!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedKiemKn,
      likeCount: 15,
      commentCount: 4,
      isLiked: false,
      likedByNames: ["Phan", "Thúy"],
      isFriend: true,
    ),
    FeedEntities(
      userName: "Athanasia",
      pathAvatar: AppIcon.avatar,
      timeAgo: "5 ngày",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đã cán mốc chuỗi 1300 ngày streak!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedStreakSelf,
      likeCount: 2475,
      commentCount: 89,
      isLiked: true,
      likedByNames: ["Mohammad", "Ali"],
      isFriend: false,
    ),
    FeedEntities(
      userName: "Ngọc Bích",
      pathAvatar: AppIcon.avatar,
      timeAgo: "1 ngày",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đã sửa tổng cộng 305 lỗi sai!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedFixBug,
      likeCount: 1,
      commentCount: 1,
      isLiked: false,
      likedByNames: ["Phan"],
      isFriend: true,
    ),
    FeedEntities(
      userName: "Kim Yến",
      pathAvatar: AppIcon.avatar,
      timeAgo: "1 ngày",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đã đạt mốc 32 Điểm Tiếng Anh!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedKiemKn,
      likeCount: 32,
      commentCount: 0,
      isLiked: true,
      likedByNames: [],
      isFriend: true,
    ),
    FeedEntities(
      userName: "Thùy Dương",
      pathAvatar: AppIcon.avatar,
      timeAgo: "4 giờ",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Vừa hoàn thành khóa học tiếng Nhật cơ bản!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedSpeak,
      likeCount: 28,
      commentCount: 5,
      isLiked: false,
      likedByNames: ["Minh", "Huy"],
      isFriend: true,
    ),
    FeedEntities(
      userName: "Hoàng Tử",
      pathAvatar: AppIcon.avatar,
      timeAgo: "1 ngày",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đã học được 15 từ vựng mới hôm nay!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feeddungnhieu,
      likeCount: 2,
      commentCount: 0,
      isLiked: false,
      likedByNames: [],
      isFriend: false,
    ),
    FeedEntities(
      userName: "Mèo Con",
      pathAvatar: AppIcon.avatar,
      timeAgo: "2 ngày",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đã hoàn thành thử thách 'Nói 50 câu tiếng Anh một ngày'!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedSpeak,
      likeCount: 45,
      commentCount: 8,
      isLiked: true,
      likedByNames: ["Hà", "Minh", "Trang"],
      isFriend: true,
    ),
    FeedEntities(
      userName: "Minh Quân",
      pathAvatar: AppIcon.avatar,
      timeAgo: "6 giờ",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đạt 300 điểm trong game luyện từ vựng!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedKiemKn,
      likeCount: 16,
      commentCount: 3,
      isLiked: false,
      likedByNames: ["Duy", "Phúc"],
      isFriend: true,
    ),
    FeedEntities(
      userName: "Hà My",
      pathAvatar: AppIcon.avatar,
      timeAgo: "3 ngày",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đã nói được 1000 câu tiếng Hàn từ lúc bắt đầu!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedSpeak,
      likeCount: 56,
      commentCount: 7,
      isLiked: false,
      likedByNames: ["Jennie", "Lisa"],
      isFriend: true,
    ),
    FeedEntities(
      userName: "T Nguyên<3",
      pathAvatar: AppIcon.avatar,
      timeAgo: "3 ngày",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Đã nói được 1000 câu tiếng Hàn từ lúc bắt đầu!"),
        ],
      ),
      contentType: FeedContentType.plainText,
      pathIcon: AppIcon.feedSpeak,
      likeCount: 56,
      commentCount: 7,
      isLiked: false,
      likedByNames: ["Jennie", "Lisa"],
      isFriend: true,
      isSelf: true
    ),
  ];
}