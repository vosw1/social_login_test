import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LogoutService {

  // Kakao 로그아웃 처리
  Future<void> logoutFromKakao() async {
    try {
      await UserApi.instance.logout();
      print("Kakao logout successful");
    } catch (e) {
      print("Kakao logout failed: $e");
    }
  }

  // Naver 로그아웃 처리
  Future<void> logoutFromNaver() async {
    try {
      final result = await FlutterNaverLogin.logOut();
      print('로그아웃 성공: $result');

      // // 서버 로그아웃 요청을 해야 브라우저에서도 로그아웃 되어 자동로그인 방지됨
      // final response = await http.post(
      //   Uri.parse('https://your-server.com/logout'),
      //   headers: {'Authorization': 'Bearer $yourAccessToken'},
      // );

    } catch (error) {
      print('로그아웃 실패, 에러: $error');
    }
  }

  // 두 서비스 모두 로그아웃 처리
  Future<void> logoutFromBoth() async {
    try {
      await Future.wait([
        logoutFromKakao(),
        logoutFromNaver(),
      ]);
      print("Successfully logged out from both Kakao and Naver");
    } catch (e) {
      print("Failed to log out from one or both services: $e");
    }
  }
}