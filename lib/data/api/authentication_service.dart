import '../model/user.dart';

abstract class AuthenticationService {
  Future<User?> getCurrentUser();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<void>? signOut();
}

class FakeAuthenticationService extends AuthenticationService {
  @override
  Future<User?> getCurrentUser() async {
    return const User(id: 0); // return null for now
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(
        const Duration(seconds: 1)); // simulate a network delay

    if (email.toLowerCase() != 'test@domain.com' || password != 'testpass123') {
      throw Exception('Wrong username or password');
    }
    return User(name: 'Test User', email: email, id: 0);
  }

  @override
  Future<void>? signOut() {
    return null;
  }
}
