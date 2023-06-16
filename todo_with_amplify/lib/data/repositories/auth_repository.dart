import 'package:amplify_flutter/amplify_flutter.dart';

class AuthRepository {
  final AuthCategory auth = Amplify.Auth;

  // fetch user id
  Future<String> _fetchUserIdFromAttribute() async {
    try {
      final attributes = await auth.fetchUserAttributes();

      final subAttribute = attributes.firstWhere((element) {
        return element.userAttributeKey == 'sub';
      });

      final userId = subAttribute.value;

      return userId;
    } catch (e) {
      rethrow;
    }
  }

  // sign in
  Future<String> webSignIn() async {
    try {
      var result = await auth.signInWithWebUI();

      if (result.isSignedIn) {
        // get user id
        return await _fetchUserIdFromAttribute();
      } else {
        // user is signed out
        throw Exception('could not sign in');
      }
    } catch (e) {
      rethrow;
    }
  }

  // auto sign in
  Future<String> attemptAutoSignIn() async {
    try {
      // get user id
      final session = await auth.fetchAuthSession();
      if (session.isSignedIn) {
        return await _fetchUserIdFromAttribute();
      } else {
        throw Exception('not signed in');
      }
    } catch (e) {
      rethrow;
    }
  }

  // sign out
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
