import 'package:flutter/foundation.dart';

enum UserRole {
  player,
  communityLeader,
  admin,
}

class UserModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String? email;
  final String? profileImageUrl;
  final UserRole role;
  final List<String> communityIds;
  final int communityRank;
  final int tournamentRank;
  final List<String> badges;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.email,
    this.profileImageUrl,
    required this.role,
    required this.communityIds,
    required this.communityRank,
    required this.tournamentRank,
    required this.badges,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${json['role']}',
        orElse: () => UserRole.player,
      ),
      communityIds: List<String>.from(json['communityIds'] ?? []),
      communityRank: json['communityRank'] as int? ?? 0,
      tournamentRank: json['tournamentRank'] as int? ?? 0,
      badges: List<String>.from(json['badges'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'role': role.toString().split('.').last,
      'communityIds': communityIds,
      'communityRank': communityRank,
      'tournamentRank': tournamentRank,
      'badges': badges,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? profileImageUrl,
    UserRole? role,
    List<String>? communityIds,
    int? communityRank,
    int? tournamentRank,
    List<String>? badges,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      role: role ?? this.role,
      communityIds: communityIds ?? this.communityIds,
      communityRank: communityRank ?? this.communityRank,
      tournamentRank: tournamentRank ?? this.tournamentRank,
      badges: badges ?? this.badges,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.profileImageUrl == profileImageUrl &&
        other.role == role &&
        listEquals(other.communityIds, communityIds) &&
        other.communityRank == communityRank &&
        other.tournamentRank == tournamentRank &&
        listEquals(other.badges, badges) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        profileImageUrl.hashCode ^
        role.hashCode ^
        communityIds.hashCode ^
        communityRank.hashCode ^
        tournamentRank.hashCode ^
        badges.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
