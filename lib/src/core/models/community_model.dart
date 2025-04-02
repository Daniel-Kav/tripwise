import 'package:flutter/foundation.dart';

enum CommunityStatus {
  active,
  inactive,
  pending,
}

class CommunityModel {
  final String id;
  final String name;
  final String region;
  final String? description;
  final String? imageUrl;
  final String leaderId;
  final List<String> memberIds;
  final List<String> pendingMemberIds;
  final CommunityStatus status;
  final int memberCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  CommunityModel({
    required this.id,
    required this.name,
    required this.region,
    this.description,
    this.imageUrl,
    required this.leaderId,
    required this.memberIds,
    required this.pendingMemberIds,
    required this.status,
    required this.memberCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      id: json['id'] as String,
      name: json['name'] as String,
      region: json['region'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      leaderId: json['leaderId'] as String,
      memberIds: List<String>.from(json['memberIds'] ?? []),
      pendingMemberIds: List<String>.from(json['pendingMemberIds'] ?? []),
      status: CommunityStatus.values.firstWhere(
        (e) => e.toString() == 'CommunityStatus.${json['status']}',
        orElse: () => CommunityStatus.pending,
      ),
      memberCount: json['memberCount'] as int? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'region': region,
      'description': description,
      'imageUrl': imageUrl,
      'leaderId': leaderId,
      'memberIds': memberIds,
      'pendingMemberIds': pendingMemberIds,
      'status': status.toString().split('.').last,
      'memberCount': memberCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  CommunityModel copyWith({
    String? id,
    String? name,
    String? region,
    String? description,
    String? imageUrl,
    String? leaderId,
    List<String>? memberIds,
    List<String>? pendingMemberIds,
    CommunityStatus? status,
    int? memberCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CommunityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      region: region ?? this.region,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      leaderId: leaderId ?? this.leaderId,
      memberIds: memberIds ?? this.memberIds,
      pendingMemberIds: pendingMemberIds ?? this.pendingMemberIds,
      status: status ?? this.status,
      memberCount: memberCount ?? this.memberCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is CommunityModel &&
        other.id == id &&
        other.name == name &&
        other.region == region &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.leaderId == leaderId &&
        listEquals(other.memberIds, memberIds) &&
        listEquals(other.pendingMemberIds, pendingMemberIds) &&
        other.status == status &&
        other.memberCount == memberCount &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        region.hashCode ^
        description.hashCode ^
        imageUrl.hashCode ^
        leaderId.hashCode ^
        memberIds.hashCode ^
        pendingMemberIds.hashCode ^
        status.hashCode ^
        memberCount.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
