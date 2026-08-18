import 'package:duolingo_ui_clone/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icon.dart';
import '../../../../domain/entities/feed_entities.dart';
import 'like_by_section.dart';


class FeedItemWidget extends StatefulWidget {
  final FeedEntities item;

  const FeedItemWidget({super.key, required this.item});

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  late bool _isLiked;
  late int _likeCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.item.isLiked;
    _likeCount = widget.item.likeCount ?? 0;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount = _isLiked ? _likeCount + 1 : _likeCount - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FeedHeaderItem(
                userName: widget.item.userName,
                avatar: widget.item.pathAvatar,
                actionText: widget.item.actionText,
                timeAgo: widget.item.timeAgo,
              ),
              const SizedBox(height: 12),
              FeedBodyItem(
                content: widget.item.content,
                contentType: widget.item.contentType,

                iconPath: widget.item.pathIcon,
              ),
              const SizedBox(height: 12),
              FeedFooterItem(
                isLiked: _isLiked,
                likeCount: _likeCount,
                isFriend: widget.item.isFriend,
                isSelf: widget.item.isSelf,
                likedByNames: widget.item.likedByNames,
                onLikePressed: _toggleLike,
              ),
              const SizedBox(height: 12),

               Divider(height: 2, thickness: 2, color: AppColors.grayBorder200,),
            ],
          ),
        ),
        // Divider ngăn cách các item
      ],
    );
  }
}


class FeedHeaderItem extends StatelessWidget {
  final String userName;
  final String? actionText;
  final String timeAgo;
  final String avatar;

  const FeedHeaderItem({
    super.key,
    required this.userName,
    this.actionText,
    required this.timeAgo,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Avatar
        Image.asset(
          avatar,
          width: 42,
        ),
        const SizedBox(width: 12),
        // Name + Action + Time
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: userName),
                    if (actionText != null)
                      TextSpan(
                        text: " $actionText",
                        style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                timeAgo,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 5. BODY COMPONENT (Xử lý 2 kiểu layout Icon)
// ==========================================
class FeedBodyItem extends StatelessWidget {
  final String content;
  final FeedContentType contentType;
  final String iconPath;

  const FeedBodyItem({
    super.key,
    required this.content,
    required this.contentType,
  required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    // Sử dụng Row, Expanded cho nội dung bên trái
    // Transform.translate để dịch chuyển Icon lên trên nếu là plainText
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildContentWidget(),
        ),
        const SizedBox(width: 10),
        // Icon bên phải
        Transform.translate(
          offset: Offset(0, contentType == FeedContentType.plainText ? -35 : 0),
          child: Image.asset(
              iconPath,
            width: 48,
          ),

        ),
      ],
    );
  }

  Widget _buildContentWidget() {
    if (contentType == FeedContentType.textCard) {
      // Kiểu 1: Text nằm trong Card xám (như "a big potato")
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E5E5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.flag, color: Colors.red, size: 20), // Giả lập cờ Mỹ
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              "một củ khoai tây to", // Giả lập nghĩa
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      );
    } else {
      // Kiểu 2: Text thường (như "400 ngày streak")
      return Padding(
        padding: const EdgeInsets.only(top: 10), // Căn chỉnh nhẹ cho thẳng hàng với icon
        child: Text(
          content,
          style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),
        ),
      );
    }
  }
}


// ==========================================
// 6. FOOTER COMPONENT (Buttons, Liked by, Comments)
// ==========================================
class FeedFooterItem extends StatelessWidget {
  final bool isLiked;
  final int likeCount;
  final bool isFriend;
  final bool isSelf;
  final List<String> likedByNames;
  final VoidCallback onLikePressed;

  const FeedFooterItem({
    super.key,
    required this.isLiked,
    required this.likeCount,
    required this.isFriend,
    required this.isSelf,
    required this.likedByNames,
    required this.onLikePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppButton(
              icon: isLiked ? Icons.favorite : Icons.favorite_border,
              iconColor: isLiked ? AppColors.duoGreen : AppColors.grayBorder300,
              label: likeCount.toString(),
              onPressed: () => onLikePressed(),
              variant: ButtonVariant.neutral,
            ),

            const SizedBox(width: 8,),

            if (isFriend)
              AppButton(
                icon: Icons.chat_bubble_outline,
                iconColor: AppColors.grayBorder300,
                label: "1", //mock
                onPressed: () {},
                variant: ButtonVariant.neutral,

              ),

            const SizedBox(width: 8,),

            if (isSelf)
              AppButton(
                iconPath: AppIcon.shareDisable,
                onPressed: () {},
                variant: ButtonVariant.neutral,

              ),
          ],
        ),

        const SizedBox(height: 8),

        // avt xếp chồng - stack
        if (likedByNames.isNotEmpty) LikedBySection(names: likedByNames),

        const SizedBox(height: 8),

        // --- Comment Preview (Giả lập 1 comment) ---
        if (isFriend)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppIcon.avatar, width: 18,),
              const SizedBox(width: 8),
              Expanded(
                child: Row(
                  children: [
                    Text( "T Nguyên<3 ", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text( "1"),
                  ],
                )

                // RichText(
                //   text: const TextSpan(
                //     style: TextStyle(fontSize: 13, color: Colors.black),
                //     children: [
                //
                //     ],
                //   ),
                // ),
              ),
            ],
          ),
      ],
    );
  }
}