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
      await FlutterNaverLogin.logOut();
      print("Naver logout successful");
    } catch (e) {
      print("Naver logout failed: $e");
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