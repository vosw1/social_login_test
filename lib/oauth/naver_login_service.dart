import 'package:flutter_naver_login/flutter_naver_login.dart';

class NaverLoginService {

  Future<void> login() async {
    try {
      // 네이버 로그인 시도
      final NaverLoginResult result = await FlutterNaverLogin.logIn();

      // 현재 액세스 토큰 가져오기
      final NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;

      // 액세스 토큰 및 토큰 타입 출력
      print("======accesToken: ${res.accessToken}");
      print("======tokenType: ${res.tokenType}");
    } catch (e) {
      // 로그인 과정에서 오류 발생 시 처리
      print("로그인 중 오류 발생: $e");
    }
  }
}