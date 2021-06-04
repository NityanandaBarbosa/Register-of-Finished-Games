import 'package:finished_games_register/app/modules/shared/services/users/users_api_interface.dart';
import 'package:http/http.dart';
import 'dart:convert';

class UsersApi implements IUsersApi {
  var url = Uri.parse(
      'https://finishedgamesregister-default-rtdb.firebaseio.com//user.json');

  @override
  Future getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

  @override
  Future postUser(user) async {
    print("userId");
    print(user.user.email);
    print(user.user.uid);
    var response = await post(url,
        body: json.encode({'userId': user.user.uid, 'email': user.user.email}));
    var id = jsonDecode(response.body);
    print("Try to post");
    print(id);
  }
}