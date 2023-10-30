import 'dart:async';

import 'package:flutter_grpc_poc/domain/user.dart';
import 'package:flutter_grpc_poc/repository/proto/service.pbgrpc.dart';
import 'package:grpc/grpc.dart';

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

  Future<List<ApplicationUser>> bulkLoadCreateUserClientStream({
    usersStreamController = Stream<ApplicationUser>
  }) async {
    Stream<User> userRequestStream = usersStreamController.asyncMap<User>((user) {
      return User(
          username: user.username,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          phone: user.phone,
          birthDate: Timestamp.fromDateTime(
              user.birthDate ?? DateTime.fromMillisecondsSinceEpoch(0)));
    });
    UserBulkLoadResponse response =
      await _userServiceClient.bulkLoadClientStream(userRequestStream);
    List<ApplicationUser> createdUsers = List.empty(growable: true);
    for (CreatedUser user in response.createdUsers) {
      createdUsers.add(
          ApplicationUser.withIdAndUsername(
              id: user.id.toInt(),
              username: user.username));
    }
    return createdUsers;
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

  Stream<ApplicationUser> bulkLoadCreateUserBidirectionalStream({
    usersStreamController = StreamController<ApplicationUser>
  }) {
    Stream<User> userRequestStream = usersStreamController.asyncMap<User>((user) {
      return User(
          username: user.username,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          phone: user.phone,
          birthDate: Timestamp.fromDateTime(
              user.birthDate ?? DateTime.fromMillisecondsSinceEpoch(0)));
    });
    ResponseStream<CreatedUser> responseStream =
      _userServiceClient.bulkLoadBidirectionalStream(userRequestStream);
    return responseStream.asyncMap((event) {
      return ApplicationUser.withIdAndUsername(
          id: event.id.toInt(),
          username: event.username);
    });
  }
}
