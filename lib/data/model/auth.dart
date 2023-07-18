import 'package:shared_preferences/shared_preferences.dart';
import 'user.dart';

class Auth {
  /// private constructor
  Auth._() {
    _doneFuture = init();
  }

  late Future<User> _doneFuture;
  

  Future<User> init() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("user")) {
      return User.fromJson(prefs.getString('user') ?? "");
    } else {
      return User.empty;
    }
  }

  late SharedPreferences prefs;

  /// the one and only instance of this singleton
  static final instance = Auth._();
  //ChatBloc chatBloc = ChatBloc(DatabaseApi.db);

  // Create a User instance. Actually it would be better if this is empty so I can notice if a user is valid or not and can react by checking if the user has values and
  // if not log the user out later on
  // User currentUser = User.empty;

  Future<User> get currentUser => init();

  updateCurrentUserInstance(User user) async {
    SharedPreferences.getInstance().then((sharedUser) {
      sharedUser.setString("user", user.toJson());
    });
  }
}
