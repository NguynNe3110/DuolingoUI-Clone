import 'package:duolingo_ui_clone/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_mobilehub/core/app_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/routes/app_router.dart';

// import 'core/di/injection.dart';

Future<void> main() async {
  // Đảm bảo Flutter binding đã khởi tạo trước khi gọi các hàm async
  WidgetsFlutterBinding.ensureInitialized();
  debugPaintBaselinesEnabled = false; //hiển thị gạch chân để debug việc căn chỉnh chữ.
  // await dotenv.load(fileName: ".env");

  // 3. GỌI HÀM SETUP DEPENDENCIES TRƯỚC TIÊN
  // setupDependencies();

  // 4. ĐĂNG KÝ GoRouter VÀO GETIT
  // (Để GoRouterNavigator có thể lấy được nó thông qua getIt<GoRouter>())
  // Giả sử 'appRouter' là biến global được export từ file app_route.dart
  // getIt.registerLazySingleton<GoRouter>(() => appRouter);

  runApp(
    const MyApp()
    // ProviderScope(
      // thao tác với riverpod
      // child: const MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      //  bọc theem .route để có thể go route
      debugShowCheckedModeBanner: false,
      // title: 'Hub Học Flutter',
      theme: ThemeData(
          // primarySwatch: Colors.purple
        useMaterial3: true,
        textTheme: AppTextTheme.light,

      ),

      // routerConfig: appRouter, // nhúng route vào build
      // routerConfig: MockComponentRouter, // viết vào file mockScreen thì ở đây
      routerConfig: MockScreenRouter, // chỉ danh cho xây dựng cả màn hình
      // routerConfig: UiCheatRouter, //
      // routerConfig: UiPropertyReferenceRouter, // mở "Từ điển thuộc tính Flutter" (ui_property_reference.dart)


      // home: HomeScreen(),// cấu hình theo navigator 1.0 bản cũ,
      // bản mới 2.0 là đăng kí màn hình ở file config vd appRoute()
    );
  }
}
