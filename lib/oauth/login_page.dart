import 'package:flutter/material.dart';
import 'package:study_app/oauth/kakao_login_service.dart';
import 'package:study_app/oauth/logout_service.dart';
import 'package:study_app/oauth/naver_login_service.dart';

class LoginPage extends StatelessWidget {
  final KakaoLoginService _kakaoService = KakaoLoginService();
  final NaverLoginService _naverService = NaverLoginService();
  final LogoutService _logoutService = LogoutService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Kakao 로그인 버튼
            InkWell(
              onTap: () async {
                await _kakaoService.login();
              },
              child: Container(
                // 크기 조절용
                width: 200,
                height: 50,
                decoration: BoxDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // 이미지 모서리 둥글게
                  child: Image.asset(
                    'assets/images/kakao_login_large_narrow.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Naver 로그인 버튼
            InkWell(
              onTap: () async {
                await _naverService.login();
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0), // 내부 패딩 10px
                child: Container(
                  // 크기 조절용
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // 이미지 모서리 둥글게
                    child: Image.asset(
                      'assets/images/btnG_완성형.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // 로그아웃 버튼
            ElevatedButton(
              onPressed: () async {
                await _logoutService.logoutFromBoth(); // 로그아웃 처리
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey, // 네이버의 쨍한 초록색
                fixedSize: Size(200, 50), // 버튼의 너비를 200으로 설정 (높이는 50으로 설정)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 모서리를 각지게 설정
                ),
              ),
              child: Text(
                '로그아웃',
                style: TextStyle(fontSize: 18), // 텍스트 크기를 18로 설정
              ),
            ),
          ],
        ),
      ),
    );
  }
}
