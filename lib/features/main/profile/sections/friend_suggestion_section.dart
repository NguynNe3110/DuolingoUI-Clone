import 'package:duolingo_ui_clone/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icon.dart';

// ==================== MODEL ====================
class FriendSuggestion {
  final String id;
  final String name;
  final String subtitle;
  final String avatarPath;
  final bool isFollowing;

  const FriendSuggestion({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.avatarPath,
    this.isFollowing = false,
  });
}

// ==================== MAIN WIDGET ====================
class FriendSuggestionSection extends StatelessWidget {
  final List<FriendSuggestion> friends;
  final VoidCallback? onViewAll;

  const FriendSuggestionSection({
    super.key,
    required this.friends,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            'Gợi ý kết bạn',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.grey[700],
              letterSpacing: 0.1,
            ),
          ),
        ),

        // Horizontal Scrollable List
        SizedBox(
          height: 228,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: friends.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return FriendSuggestionCard(
                friend: friends[index],
                onFollow: () {
                  // TODO: Handle follow
                },
                onDismiss: () {
                  // TODO: Handle dismiss (remove item)
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class FriendSuggestionCard extends StatelessWidget {
  final FriendSuggestion friend;
  final VoidCallback onFollow;
  final VoidCallback onDismiss;

  const FriendSuggestionCard({
    super.key,
    required this.friend,
    required this.onFollow,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.grayBorder200,
          width: 2,
        )
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.06),
        //     blurRadius: 8,
        //     offset: const Offset(0, 2),
        //   ),
        // ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 24),

              // Avatar with colored ring
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.shade200,
                      Colors.pink.shade200,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        friend.avatarPath,
                        fit: BoxFit.cover,
                        width: 54,
                        // height: 74,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Name (truncated)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  friend.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  friend.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                    height: 1.3,
                  ),
                ),
              ),

              const Spacer(),

              // Follow Button
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 36,
                  // child: ElevatedButton(
                  //   onPressed: onFollow,
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: const Color(0xFF1DA1F2),
                  //     foregroundColor: Colors.white,
                  //     elevation: 0,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     textStyle: const TextStyle(
                  //       fontSize: 12,
                  //       fontWeight: FontWeight.w700,
                  //       letterSpacing: 0.5,
                  //     ),
                  //   ),
                  //   child: const Text('THEO DÕI'),
                  // ),
                  child: AppButton(
                    label: 'THEO DÕI',
                    onPressed: () => {},
                    variant: ButtonVariant.secondary,
                  ),
                ),
              ),
            ],
          ),

          // Close Button (X) - Top Right
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: onDismiss,
              child: Container(
                width: 14,
                // decoration: BoxDecoration(
                //   color: Colors.grey[200],
                //   shape: BoxShape.circle,
                // ),
                // Nếu dùng SVG, thay bằng:
                child: SvgPicture.asset(
                  AppIcon.close,
                  width: 14,
                  // colorFilter: ColorFilter.mode(
                  //   Colors.grey[600]!,
                  //   BlendMode.srcIn,
                  // ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}