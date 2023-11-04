import 'dart:async';
import 'dart:convert';

import 'package:flutter_grpc_poc/domain/user.dart';
import 'package:flutter_grpc_poc/dto/user_request.dart';
import 'package:flutter_grpc_poc/presentation/user/state/create_user.dart';
import 'package:flutter_grpc_poc/repository/proto/service.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:http/http.dart' as http;

import '../google/protobuf/timestamp.pb.dart';

class UserApiRepository {
  UserApiRepository(this._userServiceClient);

  final UserServiceClient _userServiceClient;

  Future<List<ApplicationUser>> bulkLoadCreateUserRest(
      {users = List<ApplicationUser>}) async {
    List<UserDto> bulkLoadUsers = List.empty(growable: true);
    for (ApplicationUser user in users) {
      bulkLoadUsers.add(UserDto(
          username: user.username,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          phone: user.phone,
          birthDate: Timestamp.fromDateTime(
              user.birthDate ?? DateTime.fromMillisecondsSinceEpoch(0)),
          address: AddressDto(
              country: user.country,
              city: user.city,
              state: user.state,
              address: user.address,
              postalCode: user.postalCode)));
    }
    var request = BulkLoadUserRequest(users: bulkLoadUsers);
    var body = jsonEncode(request.toJson());
    final http.Response httpResponse = await http.post(
      Uri.http('localhost:8000', 'user/bulk'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      },
      body: body,
    );
    List<CreatedUsersResponse> createdUsersResponse =
        List.empty(growable: true);
    if (httpResponse.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(httpResponse.body);
      var createdUsersResponseBody = List<CreatedUsersResponse>.from(
          responseData["createdUsers"]
              .map((userJson) => CreatedUsersResponse.fromJson(userJson)));
      createdUsersResponse.addAll(createdUsersResponseBody);
    } else {
      throw Exception(
          'Failed to make POST REST call: ${httpResponse.statusCode}');
    }
    List<ApplicationUser> createdUsers = List.empty(growable: true);
    for (CreatedUsersResponse user in createdUsersResponse) {
      createdUsers.add(ApplicationUser.withIdAndUsername(
          id: user.id, username: user.username));
    }
    return createdUsers;
  }

  Future<List<ApplicationUser>> bulkLoadCreateUserUnary(
      {users = List<ApplicationUser>}) async {
    List<User> bulkLoadUsers = List.empty(growable: true);
    for (ApplicationUser user in users) {
      bulkLoadUsers.add(User(
          username: user.username,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          phone: user.phone,
          birthDate: Timestamp.fromDateTime(
              user.birthDate ?? DateTime.fromMillisecondsSinceEpoch(0)),
          address: UserAddress(
              country: user.country,
              city: user.city,
              state: user.state,
              address: user.address,
              postalCode: user.postalCode)));
    }
    var request = UserBulkLoadRequest(users: bulkLoadUsers);
    var response = await _userServiceClient.bulkLoad(request);
    List<ApplicationUser> createdUsers = List.empty(growable: true);
    for (CreatedUser user in response.createdUsers) {
      createdUsers.add(ApplicationUser.withIdAndUsername(
          id: user.id.toInt(), username: user.username));
    }
    return createdUsers;
  }

  Future<List<ApplicationUser>> bulkLoadCreateUserClientStream(
      {usersStreamController = Stream<ApplicationUser>}) async {
    Stream<User> userRequestStream =
        usersStreamController.asyncMap<User>((user) {
      return User(
          username: user.username,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          phone: user.phone,
          birthDate: Timestamp.fromDateTime(
              user.birthDate ?? DateTime.fromMillisecondsSinceEpoch(0)),
          address: UserAddress(
              country: user.country,
              city: user.city,
              state: user.state,
              address: user.address,
              postalCode: user.postalCode));
    });
    UserBulkLoadResponse response =
        await _userServiceClient.bulkLoadClientStream(userRequestStream);
    List<ApplicationUser> createdUsers = List.empty(growable: true);
    for (CreatedUser user in response.createdUsers) {
      createdUsers.add(ApplicationUser.withIdAndUsername(
          id: user.id.toInt(), username: user.username));
    }
    return createdUsers;
  }

  Stream<ApplicationUser> bulkLoadCreateUserServerStream({
    users = List<ApplicationUser>,
  }) async* {
    List<User> bulkLoadUsers = List.empty(growable: true);
    for (ApplicationUser user in users) {
      bulkLoadUsers.add(User(
          username: user.username,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          phone: user.phone,
          birthDate: Timestamp.fromDateTime(
              user.birthDate ?? DateTime.fromMillisecondsSinceEpoch(0)),
          address: UserAddress(
              country: user.country,
              city: user.city,
              state: user.state,
              address: user.address,
              postalCode: user.postalCode)));
    }
    var request = UserBulkLoadRequest(users: bulkLoadUsers);
    await for (var createdUser
        in _userServiceClient.bulkLoadServerStream(request)) {
      ApplicationUser u = ApplicationUser.withIdAndUsername(
          id: createdUser.id.toInt(), username: createdUser.username);
      yield u;
    }
  }

  Stream<ApplicationUser> bulkLoadCreateUserBidirectionalStream(
      {usersStreamController = StreamController<ApplicationUser>}) {
    Stream<User> userRequestStream =
        usersStreamController.asyncMap<User>((user) {
      return User(
          username: user.username,
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email,
          phone: user.phone,
          birthDate: Timestamp.fromDateTime(
              user.birthDate ?? DateTime.fromMillisecondsSinceEpoch(0)),
          address: UserAddress(
              country: user.country,
              city: user.city,
              state: user.state,
              address: user.address,
              postalCode: user.postalCode));
    });
    ResponseStream<CreatedUser> responseStream =
        _userServiceClient.bulkLoadBidirectionalStream(userRequestStream);
    return responseStream.asyncMap((event) {
      return ApplicationUser.withIdAndUsername(
          id: event.id.toInt(), username: event.username);
    });
  }
}
