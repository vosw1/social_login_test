import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

class NaverLoginService {
  Future<void> login() async {
    try {
      // 네이버 로그인 시도
      final NaverLoginResult result = await FlutterNaverLogin.logIn();

      // 로그인 결과에서 사용자 정보 추출
      final account = result.account;
      final accessToken = result.accessToken; // 결과에서 액세스 토큰 직접 가져오기

      // 사용자 정보 출력
      print("======result: ${result}");
      print("======AccessToken: ${accessToken?.accessToken}");
      print("======TokenType: ${accessToken?.tokenType}");
      print("======User ID: ${account?.id}");
      print("======User Name: ${account?.name}");
      print("======User Email: ${account?.email}");
      print("======User Profile Image: ${account?.profileImage}");

    } catch (e) {
      // 로그인 과정에서 오류 발생 시 처리
      print("로그인 중 오류 발생: $e");
    }
  }
}