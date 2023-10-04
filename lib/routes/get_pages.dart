import 'package:get/route_manager.dart';
import 'package:mobile_app/app/presentation/screens/first_screen/first_screen.dart';
import 'package:mobile_app/app/presentation/screens/first_screen/first_screen_binding.dart';
import 'package:mobile_app/routes/named_routes.dart';

abstract class GetPages {
  static get pages => [
    // mason으로 생성된 아이의 screen.dart 하단에 보면 아래 코드를 주석화해서
    // 만들어놨으니 복사 해서 붙여넣으셈
    GetPage(
      // named_routes.dart 에서 생성한 static 문자열을 넣기
      name: Routes.FIRST,
      page: () => const FirstScreen(),
      binding: FirstScreenBinding(),
    )
  ];
}
