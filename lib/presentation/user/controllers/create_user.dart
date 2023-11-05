import 'dart:async';

import 'package:flutter_grpc_poc/application/user/user.dart';
import 'package:flutter_grpc_poc/domain/user.dart';

import '../state/create_user.dart';

class CreateUserController {
  CreateUserController(this._userService);

  final UserService _userService;

  Future<List<UsersResponse>> getUserRest() async {
    List<ApplicationUser> createdUsers =
        await _userService.bulkLoadGetUsersRest();
    List<UsersResponse> response = List.empty(growable: true);
    for (ApplicationUser u in createdUsers) {
      response.add(UsersResponse(
          u.id,
          u.username,
          u.firstName,
          u.lastName,
          u.email,
          u.phone,
          u.birthDate,
          u.country,
          u.city,
          u.state,
          u.address,
          u.postalCode));
    }
    return response;
  }

  Future<List<UsersResponse>> createUserRest(
      {request = List<CreateUserState>}) async {
    List<ApplicationUser> users = List.empty(growable: true);
    for (CreateUserState requestItem in request) {
      users.add(requestItem.toUser());
    }
    List<ApplicationUser> createdUsers =
        await _userService.bulkLoadCreateUsersRest(users: users);
    List<UsersResponse> response = List.empty(growable: true);
    for (ApplicationUser u in createdUsers) {
      response.add(UsersResponse(
          u.id,
          u.username,
          u.firstName,
          u.lastName,
          u.email,
          u.phone,
          u.birthDate,
          u.country,
          u.city,
          u.state,
          u.address,
          u.postalCode));
    }
    return response;
  }

  Future<List<UsersResponse>> getAllUsersUnary() async {
    List<ApplicationUser> users = await _userService.getAllUsersUnary();
    List<UsersResponse> response = List.empty(growable: true);
    for (ApplicationUser u in users) {
      response.add(UsersResponse(
          u.id,
          u.username,
          u.firstName,
          u.lastName,
          u.email,
          u.phone,
          u.birthDate,
          u.country,
          u.city,
          u.state,
          u.address,
          u.postalCode));
    }
    return response;
  }

  Future<List<UsersResponse>> createUserUnary(
      {request = List<CreateUserState>}) async {
    List<ApplicationUser> users = List.empty(growable: true);
    for (CreateUserState requestItem in request) {
      users.add(requestItem.toUser());
    }
    List<ApplicationUser> createdUsers =
        await _userService.bulkLoadCreateUsersUnary(users: users);
    List<UsersResponse> response = List.empty(growable: true);
    for (ApplicationUser u in createdUsers) {
      response.add(UsersResponse(
          u.id,
          u.username,
          u.firstName,
          u.lastName,
          u.email,
          u.phone,
          u.birthDate,
          u.country,
          u.city,
          u.state,
          u.address,
          u.postalCode));
    }
    return response;
  }

  Stream<UsersResponse> getAllUsersServerStream() async* {
    await for (ApplicationUser u in _userService.getAllUsersServerStream()) {
      yield UsersResponse(
          u.id,
          u.username,
          u.firstName,
          u.lastName,
          u.email,
          u.phone,
          u.birthDate,
          u.country,
          u.city,
          u.state,
          u.address,
          u.postalCode);
    }
  }

  Stream<UsersResponse> createUsersServerStream(
      {request = List<CreateUserState>}) async* {
    List<ApplicationUser> users = List.empty(growable: true);
    for (CreateUserState requestItem in request) {
      users.add(requestItem.toUser());
    }
    await for (ApplicationUser u
        in _userService.bulkLoadCreateUsersServerStream(users: users)) {
      yield UsersResponse(
          u.id,
          u.username,
          u.firstName,
          u.lastName,
          u.email,
          u.phone,
          u.birthDate,
          u.country,
          u.city,
          u.state,
          u.address,
          u.postalCode);
    }
  }

  Future<List<UsersResponse>> createUsersClientStream(
      {requestStreamController = Stream<CreateUserState>}) async {
    Stream<ApplicationUser> userToCreateStream =
        requestStreamController.asyncMap<ApplicationUser>((CreateUserState e) {
      return e.toUser();
    });
    List<ApplicationUser> createdUsers =
        await _userService.bulkLoadCreateUsersClientStream(
            usersStreamController: userToCreateStream);
    List<UsersResponse> response = List.empty(growable: true);
    for (ApplicationUser u in createdUsers) {
      response.add(UsersResponse(
          u.id,
          u.username,
          u.firstName,
          u.lastName,
          u.email,
          u.phone,
          u.birthDate,
          u.country,
          u.city,
          u.state,
          u.address,
          u.postalCode));
    }
    return response;
  }

  Stream<UsersResponse> createUsersBidirectionalStream(
      {requestStreamController = Stream<CreateUserState>}) async* {
    Stream<ApplicationUser> userToCreateStream =
        requestStreamController.asyncMap<ApplicationUser>((CreateUserState e) {
      return e.toUser();
    });
    await for (ApplicationUser u
        in _userService.bulkLoadCreateUsersBidirectionalStream(
            usersStreamController: userToCreateStream)) {
      yield UsersResponse(
          u.id,
          u.username,
          u.firstName,
          u.lastName,
          u.email,
          u.phone,
          u.birthDate,
          u.country,
          u.city,
          u.state,
          u.address,
          u.postalCode);
    }
  }
}
