
import 'package:duolingo_ui_clone/domain/entities/leaderboard_user.dart';

import '../../core/theme/app_icon.dart';

class LeaderboardState {
  final List<LeaderboardUser> users;

  const LeaderboardState({required this.users});


  static const List<LeaderboardUser> mock =
  [
    LeaderboardUser(rank: 1, name: 'Chiến', kn: 50, courseGrade: 2, course: AppIcon.flagVietNam, avatar: AppIcon.avatar,isActive: true),
    LeaderboardUser(rank: 2, name: 'Sharon Taylor', kn: 44, courseGrade: 1, course: AppIcon.flagFrance, avatar: AppIcon.avatar),
    LeaderboardUser(rank: 3, name: 'Dipali dixit', kn: 38, courseGrade: 61, course: AppIcon.flagRussia, avatar: AppIcon.avatar),
    LeaderboardUser(rank: 4, name: 'Chiến', kn: 36, courseGrade: 10, course: AppIcon.flagSweden, avatar: AppIcon.avatar, isActive: true),
    LeaderboardUser(rank: 5, name: 'liette', kn: 30, courseGrade: 5, course: AppIcon.flagChinese, avatar: AppIcon.avatar),
    LeaderboardUser(rank: 6, name: 'Paloma', kn: 30, courseGrade: 22, course: AppIcon.flagUnitedState, avatar: AppIcon.avatar, isActive: true),
    LeaderboardUser(rank: 7, name: 'Phattarada Saewang', kn: 27, courseGrade: 10, course: AppIcon.flagFrance, avatar: AppIcon.avatar),
    LeaderboardUser(rank: 8, name: 'Rakhi Goyal', kn: 27, courseGrade: 2, course: AppIcon.flagRussia, avatar: AppIcon.avatar, isActive: true),
    LeaderboardUser(rank: 9, name: "Chie Magome 'Shibata", kn: 25, courseGrade: 2, course: AppIcon.flagSweden, avatar: AppIcon.avatar),
    LeaderboardUser(rank: 10, name: 'Soo', kn: 22, courseGrade: 9, course: AppIcon.flagChinese, avatar: AppIcon.avatar),
    LeaderboardUser(rank: 11, name: 'Reshail Yawar', kn: 13, courseGrade: 0, course: AppIcon.flagUnitedState, avatar: AppIcon.avatar),
    LeaderboardUser(rank: 12, name: 'T Nguyên<3', kn: 8, courseGrade: 28, course: AppIcon.flagVietNam, avatar: AppIcon.avatar, isMe: true, isActive: true),
  ];

}



const List<LeaderboardUser> _users = [
];