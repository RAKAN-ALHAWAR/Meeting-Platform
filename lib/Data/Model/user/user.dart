import 'package:meeting/Core/Extension/convert/convert.dart';
import 'package:meeting/Data/Model/user/permission.dart';

import '../../../Core/Helper/model/model.dart';
import '../../Enum/ability_status.dart';
import '../../data.dart';
import '../User/role.dart';

class UserX {
  UserX({
    required this.id,
    required this.name,
    this.phone,
    required this.email,
    required this.idNumber,
    this.jobTitle,
    this.whatsappNotifications = false,
    this.emailNotifications = false,
    this.smsNotifications = false,
    this.appNotifications = false,
    this.googleCalenderNotifications = false,
    this.automaticAttendances,
    this.resetCode,
    this.imageUrl,
    this.signatureImageUrl,
    this.abilities = const[],
    this.permissions = const[],
    this.roles = const[],
    this.token="",
  });

  String id;
  String name;
  String? phone;
  String email;
  int idNumber;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? currentTeamId;
  String? jobTitle;
  bool whatsappNotifications;
  bool emailNotifications;
  bool smsNotifications;
  bool appNotifications;
  bool googleCalenderNotifications;
  bool? automaticAttendances;
  int? resetCode;
  String? imageUrl;
  String? signatureImageUrl;
  List<AbilityStatusX> abilities;
  List<PermissionX> permissions;
  List<RoleX> roles;
  String token;

  factory UserX.fromJson(Map<String, dynamic> json, String token) {
    // List<Map<String, dynamic>> signaturesJsonList = ((json[NameX.signature] ?? []) as List)
    //     .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e))
    //     .toList();
    List<AbilityStatusX> abilities = (json[NameX.abilities] as List<dynamic>?)
        ?.map((ability) => AbilityStatusX.values.firstWhere((x) => x.name==ability.toString().toLowerCase()))
        .toList() ??
        [];
    List<Map<String, dynamic>> permissionsJsonList =  List<Map<String, dynamic>>.from((json[NameX.permissions] is! List ? [] : json[NameX.permissions]) as List);
    List<Map<String, dynamic>> rolesJsonList = List<Map<String, dynamic>>.from((json[NameX.roles] is List ? json[NameX.roles] : [])
        .map((item) => (item as Map).map(
          (key, value) => MapEntry(key.toString(), value),
    )).toList());

    return ModelUtilX.checkFromJson(
      json,
          (json) {
        return UserX(
          id: json[NameX.id].toStrX,
          name: json[NameX.name].toStrX,
          phone: json[NameX.phone].toStrNullableX,
          email: json[NameX.email].toStrDefaultX(''),
          idNumber: json[NameX.idNumber].toIntDefaultX(0),
          jobTitle: json[NameX.jobTitle].toStrNullableX,
          whatsappNotifications: json[NameX.whatsappNotifications].toBoolDefaultX(false),
          emailNotifications: json[NameX.emailNotifications].toBoolDefaultX(false),
          smsNotifications: json[NameX.smsNotifications].toBoolDefaultX(false),
          appNotifications: json[NameX.appNotifications].toBoolDefaultX(false),
          googleCalenderNotifications: json[NameX.googleCalenderNotifications].toBoolDefaultX(false),
          automaticAttendances: json[NameX.automaticAttendances].toBoolNullableX,
          signatureImageUrl: json[NameX.signature].toStrNullableX,
          // signatures: signaturesJsonList.map((json) => SignatureX.fromJson(json)).toList(),
          resetCode: json[NameX.resetCode].toIntNullableX,
          imageUrl: json[NameX.profilePhotoUrl].toStrNullableX,
          abilities: abilities,
          permissions: ModelUtilX.generateItems(permissionsJsonList, PermissionX.fromJson),
          roles: rolesJsonList.map((json) => RoleX.fromJson(json)).toList(),
          token: token,
        );
      },
      requiredDataKeys: [
        NameX.id,
        NameX.name,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.name: name,
      NameX.phone: phone,
      NameX.email: email,
      NameX.idNumber: idNumber,
      NameX.jobTitle: jobTitle,
      NameX.whatsappNotifications: whatsappNotifications,
      NameX.emailNotifications: emailNotifications,
      NameX.smsNotifications: smsNotifications,
      NameX.appNotifications: appNotifications,
      NameX.googleCalenderNotifications: googleCalenderNotifications,
      NameX.automaticAttendances: automaticAttendances,
      NameX.signature: signatureImageUrl,
      NameX.resetCode: resetCode,
      NameX.profilePhotoUrl: imageUrl,
      NameX.abilities: abilities.map((role) => role.name).toList(),
      NameX.permissions: permissions.map((role) => role.toJson()).toList(),
      NameX.roles: roles.map((role) => role.toJson()).toList(),
    };
  }
}