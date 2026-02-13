import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<void> build() => null;

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {   
      await Future.delayed(const Duration(seconds: 2));

      if (email == "test@test.com" && password == "123456") {
        return;
      } else {
        throw Exception("이메일 또는 비밀번호가 틀렸습니다."); // 실패 (AsyncError가 됨)
      }
    });
  }
}
