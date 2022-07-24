import 'package:tutor_group/utils/datamodel_users.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<UsersModel> fetchData() async {
    UsersModel? users;
    Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/users');

    http.Response response =
        await http.get(uri).catchError((err) => print(err));

    users = UsersModel.fromJson(response.body);
    return users;
  }
}
