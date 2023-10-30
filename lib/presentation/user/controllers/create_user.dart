import 'dart:async';

import 'package:flutter_grpc_poc/application/user/user.dart';
import 'package:flutter_grpc_poc/domain/user.dart';

import '../state/create_user.dart';

class CreateUserController {

  CreateUserController(this._userService);

  final UserService _userService;

  Future<List<CreatedUsersResponse>> createUser({
    request = List<CreateUserState>
  }) async {
    List<ApplicationUser> users = List.empty(growable: true);
    for (CreateUserState requestItem in request) {
      users.add(requestItem.toUser());
    }
    List<ApplicationUser> createdUsers =
      await _userService.bulkLoadCreateUsers(users: users);
    List<CreatedUsersResponse> response = List.empty(growable: true);
    for (ApplicationUser u in createdUsers) {
      response.add(CreatedUsersResponse(u.id, u.username));
    }
    return response;
  }

  Stream<CreatedUsersResponse> createUsersServerStream({
    request = List<CreateUserState>
  }) async* {
    List<ApplicationUser> users = List.empty(growable: true);
    for (CreateUserState requestItem in request) {
      users.add(requestItem.toUser());
    }
    await for (ApplicationUser createdUser in _userService.bulkLoadCreateUsersServerStream(users: users)) {
      yield CreatedUsersResponse(createdUser.id, createdUser.username);
    }
  }

  Future<List<CreatedUsersResponse>> createUsersClientStream({
    requestStreamController = Stream<CreateUserState>
  }) async {
    Stream<ApplicationUser> userToCreateStream = requestStreamController.asyncMap<ApplicationUser>((CreateUserState e) {
      return e.toUser();
    });
    List<ApplicationUser> createdUsers =
      await _userService.bulkLoadCreateUsersClientStream(usersStreamController: userToCreateStream);
    List<CreatedUsersResponse> response = List.empty(growable: true);
    for (ApplicationUser u in createdUsers) {
      response.add(CreatedUsersResponse(u.id, u.username));
    }
    return response;
  }

  Stream<CreatedUsersResponse> createUsersBidirectionalStream({
    requestStreamController = Stream<CreateUserState>
  }) async* {
    Stream<ApplicationUser> userToCreateStream = requestStreamController.asyncMap<ApplicationUser>((CreateUserState e) {
      return e.toUser();
    });
    await for (ApplicationUser createdUser in _userService.bulkLoadCreateUsersBidirectionalStream(usersStreamController: userToCreateStream)) {
      yield CreatedUsersResponse(createdUser.id, createdUser.username);
    }
  }
}
