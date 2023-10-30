import 'package:flutter_grpc_poc/domain/user.dart';
import 'package:flutter_grpc_poc/repository/proto/service.pbgrpc.dart';

import '../google/protobuf/timestamp.pb.dart';

class UserApiRepository {

  UserApiRepository(this._userServiceClient);

  final UserServiceClient _userServiceClient;

  Future<List<ApplicationUser>> bulkLoadCreateUserUnary({
    users = List<ApplicationUser>
  }) async {
    List<User> bulkLoadUsers = List.empty(growable: true);
    for (ApplicationUser user in users) {
      bulkLoadUsers.add(
          User(
              username: user.username,
              firstName: user.firstName,
              lastName: user.lastName,
              email: user.email,
              phone: user.phone,
              birthDate: Timestamp.fromDateTime(
                  user.birthDate ?? DateTime.fromMillisecondsSinceEpoch(0))
          )
      );
    }
    var request = UserBulkLoadRequest(users: bulkLoadUsers);
    var response = await _userServiceClient.bulkLoad(request);
    List<ApplicationUser> createdUsers = List.empty(growable: true);
    for (CreatedUser user in response.createdUsers) {
      createdUsers.add(
          ApplicationUser.withIdAndUsername(
              id: user.id.toInt(),
              username: user.username));
    }
    return createdUsers;
  }

  Future<void> bulkLoadCreateUserClientStream({
    stream = Stream<ApplicationUser>
  }) async {
    _userServiceClient.bulkLoadClientStream(stream);
  }

  Stream<ApplicationUser> bulkLoadCreateUserServerStream({
    users = List<ApplicationUser>,
  }) async* {
    List<User> bulkLoadUsers = List.empty(growable: true);
    for (ApplicationUser user in users) {
      bulkLoadUsers.add(
          User(
              username: user.username,
              firstName: user.firstName,
              lastName: user.lastName,
              email: user.email,
              phone: user.phone,
              birthDate: Timestamp.fromDateTime(
                  user.birthDate ?? DateTime.fromMillisecondsSinceEpoch(0))
          )
      );
    }
    var request = UserBulkLoadRequest(users: bulkLoadUsers);
    await for (var createdUser in _userServiceClient.bulkLoadServerStream(request)) {
      ApplicationUser u = ApplicationUser.withIdAndUsername(
          id: createdUser.id.toInt(),
          username: createdUser.username);
      yield u;
    }
  }
}
