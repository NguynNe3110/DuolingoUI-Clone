
// ==========================================
// 1. DATA MODEL (Tương tự Data Class trong Kotlin)
// ==========================================
import 'package:flutter/cupertino.dart';

enum FeedContentType { plainText, textCard, achievement }

class FeedEntities {
  final String userName;
  final String pathAvatar;
  final String? actionText; // VD: "đã chia sẻ một câu"
  final String timeAgo;
  final String content;
  final FeedContentType contentType;
  final String pathIcon;
  final int? likeCount;
  final int? commentCount;
  final bool isLiked;
  final List<String> likedByNames; // Tên những người thích
  final bool isFriend; // Để hiện nút bình luận
  final bool isSelf; // Để hiện nút share

  FeedEntities({
    required this.userName,
    required this.pathAvatar,
    this.actionText,
    required this.timeAgo,
    required this.content,
    required this.contentType,
    required this.pathIcon,
    this.likeCount,
    this.commentCount,
    required this.isLiked,
    required this.likedByNames,
    this.isFriend = false,
    this.isSelf = false,
  });
}
