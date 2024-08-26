import 'dart:convert';
import 'package:uni_links/uni_links.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NaverOAuthService {
  final String _authorizationEndpoint = 'https://nid.naver.com/oauth2.0/authorize';
  final String _tokenEndpoint = 'https://nid.naver.com/oauth2.0/token';
  final String _clientId = 'mlwJlo7cWuSqQjBF09JL';
  final String _clientSecret = 'E4RAP0401T';
  final String _redirectUri = 'studyapp://callback'; // 고정된 리디렉션 URI
  final String _scope = 'profile';

  Future<void> login(BuildContext context) async {
    try {
      final authorizationUrl = _getAuthorizationUrl();
      print('========== 네이버 로그인 시작 URL: $authorizationUrl');

      if (await canLaunchUrl(authorizationUrl)) {
        await launchUrl(authorizationUrl);
        final authCode = await _getAuthorizationCode();

        if (authCode != null) {
          print('========== 인증 코드 획득: $authCode');
          await _requestToken(authCode, context);
        } else {
          throw '========== 인증 코드가 없습니다';
        }
      } else {
        throw '========== $authorizationUrl을 열 수 없습니다';
      }
    } catch (e) {
      print('========== 로그인 오류: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패: $e')),
      );
    }
  }

  Uri _getAuthorizationUrl() {
    return Uri.parse(
      '$_authorizationEndpoint?client_id=$_clientId&redirect_uri=$_redirectUri&response_type=code&scope=$_scope',
    );
  }

  Future<String?> _getAuthorizationCode() async {
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        print('========== 초기 링크: $initialLink');
        final uri = Uri.parse(initialLink);
        final code = uri.queryParameters['code'];
        print('========== 초기 링크에서 추출된 코드: $code');
        return code;
      }
    } catch (e) {
      print('========== 링크 처리 오류: $e');
    }

    final initialLinkStream = uriLinkStream;
    await for (final link in initialLinkStream) {
      if (link != null) {
        print('========== 스트림에서 수신된 링크: $link');
        final uri = Uri.parse(link as String);
        final code = uri.queryParameters['code'];
        print('========== 스트림에서 추출된 코드: $code');
        if (code != null) return code;
      }
    }
    return null;
  }

  Future<void> _requestToken(String authCode, BuildContext context) async {
    print('========== 토큰 요청 시작');
    print('========== 요청 URL: ${Uri.parse(_tokenEndpoint)}');
    print('========== 요청 바디: ${jsonEncode({
      'grant_type': 'authorization_code',
      'client_id': _clientId,
      'client_secret': _clientSecret,
      'redirect_uri': _redirectUri,
      'code': authCode,
    })}');

    final response = await http.post(
      Uri.parse(_tokenEndpoint),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'authorization_code',
        'client_id': _clientId,
        'client_secret': _clientSecret,
        'redirect_uri': _redirectUri,
        'code': authCode,
      },
    );

    print('========== 토큰 요청 상태 코드: ${response.statusCode}');
    print('========== 토큰 요청 응답 본문: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data['access_token'];
      print('========== 네이버 액세스 토큰: $accessToken');
      _onLoginSuccess(context, accessToken);
    } else {
      throw '========== 액세스 토큰 요청 실패: ${response.body}';
    }
  }

  void _onLoginSuccess(BuildContext context, String accessToken) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('로그인에 성공했습니다'),
        duration: Duration(seconds: 2),
      ),
    );
    print('========== 로그인 성공! 액세스 토큰: $accessToken');
  }
}