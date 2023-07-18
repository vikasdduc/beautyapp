import 'package:glamcode/data/model/auth.dart';
import 'package:glamcode/data/model/user.dart';

import '../api/api_helper.dart';

class UserRepository {
  Auth auth = Auth.instance;
  DioClient dioClient = DioClient.instance;
  UserRepository({required this.auth, required this.dioClient});

  // Send otp to phone number

  Future<bool> sendOtp(String phoneNumber, String referlcode) async {
    try {
      return await dioClient.sendOtp(phoneNumber, referlcode) ?? false;
      print(phoneNumber + referlcode);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<bool> verifyOtp(String otp, String phoneNumber) async {
    try {
      User? user = await dioClient.verifyOtp(otp, phoneNumber);
      if (user != null) {
        auth.updateCurrentUserInstance(user);
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // sign in with username
  Future<User> signIn(String phoneNumber) async {
    try {
      User credentials = const User(id: 1);
      auth.updateCurrentUserInstance(credentials);
      print('signed id with credentials: ${await auth.currentUser}');
      return auth.currentUser;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<User> signOut() async {
    try {
      User credentials = const User(id: 0);
      auth.updateCurrentUserInstance(credentials);
      print('signed out with credentials: ${await auth.currentUser}');
      return auth.currentUser;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // check signed in status
  Future<bool> isSignedIn() async {
    try {
      User currentUser = await auth.currentUser;
      if (currentUser.isNotEmpty) {
        print('user is signed in');
        return true;
      } else {
        print('user is NOT signed in');
        return false;
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // get user
  Future<User> getCurrentUser() async {
    try {
      User currentUser = await auth.currentUser;
      if (currentUser.isNotEmpty) {
        print('currentuser is not empty: $currentUser');
        return currentUser;
      } else {
        var message = 'User is empty';
        print('currentuser IS empty: $currentUser');
        throw message;
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<bool> updateCurrentUser(User user) async {
    try {
      await dioClient.editProfile(user);
      auth.updateCurrentUserInstance(user);
      return true;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
