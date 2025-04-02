import 'package:flutter/foundation.dart';

enum TournamentStatus {
  upcoming,
  ongoing,
  completed,
  cancelled,
}

enum TournamentLevel {
  community,
  regional,
  national,
}

class TournamentModel {
  final String id;
  final String name;
  final String description;
  final String organizerId;
  final String? communityId;
  final String region;
  final DateTime startDate;
  final DateTime endDate;
  final TournamentStatus status;
  final TournamentLevel level;
  final int maxParticipants;
  final List<String> participantIds;
  final List<MatchModel> matches;
  final String? winnerUserId;
  final String? runnerUpUserId;
  final String? venue;
  final String? imageUrl;
  final List<String> sponsorIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  TournamentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.organizerId,
    this.communityId,
    required this.region,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.level,
    required this.maxParticipants,
    required this.participantIds,
    required this.matches,
    this.winnerUserId,
    this.runnerUpUserId,
    this.venue,
    this.imageUrl,
    required this.sponsorIds,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TournamentModel.fromJson(Map<String, dynamic> json) {
    return TournamentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      organizerId: json['organizerId'] as String,
      communityId: json['communityId'] as String?,
      region: json['region'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      status: TournamentStatus.values.firstWhere(
        (e) => e.toString() == 'TournamentStatus.${json['status']}',
        orElse: () => TournamentStatus.upcoming,
      ),
      level: TournamentLevel.values.firstWhere(
        (e) => e.toString() == 'TournamentLevel.${json['level']}',
        orElse: () => TournamentLevel.community,
      ),
      maxParticipants: json['maxParticipants'] as int,
      participantIds: List<String>.from(json['participantIds'] ?? []),
      matches: (json['matches'] as List<dynamic>?)
              ?.map((e) => MatchModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      winnerUserId: json['winnerUserId'] as String?,
      runnerUpUserId: json['runnerUpUserId'] as String?,
      venue: json['venue'] as String?,
      imageUrl: json['imageUrl'] as String?,
      sponsorIds: List<String>.from(json['sponsorIds'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'organizerId': organizerId,
      'communityId': communityId,
      'region': region,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status.toString().split('.').last,
      'level': level.toString().split('.').last,
      'maxParticipants': maxParticipants,
      'participantIds': participantIds,
      'matches': matches.map((e) => e.toJson()).toList(),
      'winnerUserId': winnerUserId,
      'runnerUpUserId': runnerUpUserId,
      'venue': venue,
      'imageUrl': imageUrl,
      'sponsorIds': sponsorIds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  TournamentModel copyWith({
    String? id,
    String? name,
    String? description,
    String? organizerId,
    String? communityId,
    String? region,
    DateTime? startDate,
    DateTime? endDate,
    TournamentStatus? status,
    TournamentLevel? level,
    int? maxParticipants,
    List<String>? participantIds,
    List<MatchModel>? matches,
    String? winnerUserId,
    String? runnerUpUserId,
    String? venue,
    String? imageUrl,
    List<String>? sponsorIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TournamentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      organizerId: organizerId ?? this.organizerId,
      communityId: communityId ?? this.communityId,
      region: region ?? this.region,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      level: level ?? this.level,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      participantIds: participantIds ?? this.participantIds,
      matches: matches ?? this.matches,
      winnerUserId: winnerUserId ?? this.winnerUserId,
      runnerUpUserId: runnerUpUserId ?? this.runnerUpUserId,
      venue: venue ?? this.venue,
      imageUrl: imageUrl ?? this.imageUrl,
      sponsorIds: sponsorIds ?? this.sponsorIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TournamentModel &&
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.organizerId == organizerId &&
      other.communityId == communityId &&
      other.region == region &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.status == status &&
      other.level == level &&
      other.maxParticipants == maxParticipants &&
      listEquals(other.participantIds, participantIds) &&
      listEquals(other.matches, matches) &&
      other.winnerUserId == winnerUserId &&
      other.runnerUpUserId == runnerUpUserId &&
      other.venue == venue &&
      other.imageUrl == imageUrl &&
      listEquals(other.sponsorIds, sponsorIds) &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      organizerId.hashCode ^
      communityId.hashCode ^
      region.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      status.hashCode ^
      level.hashCode ^
      maxParticipants.hashCode ^
      participantIds.hashCode ^
      matches.hashCode ^
      winnerUserId.hashCode ^
      runnerUpUserId.hashCode ^
      venue.hashCode ^
      imageUrl.hashCode ^
      sponsorIds.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}

enum MatchStatus {
  scheduled,
  ongoing,
  completed,
  cancelled,
}

class MatchModel {
  final String id;
  final String tournamentId;
  final String player1Id;
  final String player2Id;
  final int? player1Score;
  final int? player2Score;
  final String? winnerId;
  final MatchStatus status;
  final DateTime scheduledTime;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? notes;
  final int round;
  final int matchNumber;
  final String? refereeId;
  final String? tableNumber;
  final List<String>? highlights;
  final DateTime createdAt;
  final DateTime updatedAt;

  MatchModel({
    required this.id,
    required this.tournamentId,
    required this.player1Id,
    required this.player2Id,
    this.player1Score,
    this.player2Score,
    this.winnerId,
    required this.status,
    required this.scheduledTime,
    this.startTime,
    this.endTime,
    this.notes,
    required this.round,
    required this.matchNumber,
    this.refereeId,
    this.tableNumber,
    this.highlights,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'] as String,
      tournamentId: json['tournamentId'] as String,
      player1Id: json['player1Id'] as String,
      player2Id: json['player2Id'] as String,
      player1Score: json['player1Score'] as int?,
      player2Score: json['player2Score'] as int?,
      winnerId: json['winnerId'] as String?,
      status: MatchStatus.values.firstWhere(
        (e) => e.toString() == 'MatchStatus.${json['status']}',
        orElse: () => MatchStatus.scheduled,
      ),
      scheduledTime: DateTime.parse(json['scheduledTime'] as String),
      startTime: json['startTime'] != null
          ? DateTime.parse(json['startTime'] as String)
          : null,
      endTime: json['endTime'] != null
          ? DateTime.parse(json['endTime'] as String)
          : null,
      notes: json['notes'] as String?,
      round: json['round'] as int,
      matchNumber: json['matchNumber'] as int,
      refereeId: json['refereeId'] as String?,
      tableNumber: json['tableNumber'] as String?,
      highlights: json['highlights'] != null
          ? List<String>.from(json['highlights'] as List<dynamic>)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tournamentId': tournamentId,
      'player1Id': player1Id,
      'player2Id': player2Id,
      'player1Score': player1Score,
      'player2Score': player2Score,
      'winnerId': winnerId,
      'status': status.toString().split('.').last,
      'scheduledTime': scheduledTime.toIso8601String(),
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'notes': notes,
      'round': round,
      'matchNumber': matchNumber,
      'refereeId': refereeId,
      'tableNumber': tableNumber,
      'highlights': highlights,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  MatchModel copyWith({
    String? id,
    String? tournamentId,
    String? player1Id,
    String? player2Id,
    int? player1Score,
    int? player2Score,
    String? winnerId,
    MatchStatus? status,
    DateTime? scheduledTime,
    DateTime? startTime,
    DateTime? endTime,
    String? notes,
    int? round,
    int? matchNumber,
    String? refereeId,
    String? tableNumber,
    List<String>? highlights,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MatchModel(
      id: id ?? this.id,
      tournamentId: tournamentId ?? this.tournamentId,
      player1Id: player1Id ?? this.player1Id,
      player2Id: player2Id ?? this.player2Id,
      player1Score: player1Score ?? this.player1Score,
      player2Score: player2Score ?? this.player2Score,
      winnerId: winnerId ?? this.winnerId,
      status: status ?? this.status,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      notes: notes ?? this.notes,
      round: round ?? this.round,
      matchNumber: matchNumber ?? this.matchNumber,
      refereeId: refereeId ?? this.refereeId,
      tableNumber: tableNumber ?? this.tableNumber,
      highlights: highlights ?? this.highlights,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MatchModel &&
      other.id == id &&
      other.tournamentId == tournamentId &&
      other.player1Id == player1Id &&
      other.player2Id == player2Id &&
      other.player1Score == player1Score &&
      other.player2Score == player2Score &&
      other.winnerId == winnerId &&
      other.status == status &&
      other.scheduledTime == scheduledTime &&
      other.startTime == startTime &&
      other.endTime == endTime &&
      other.notes == notes &&
      other.round == round &&
      other.matchNumber == matchNumber &&
      other.refereeId == refereeId &&
      other.tableNumber == tableNumber &&
      listEquals(other.highlights, highlights) &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      tournamentId.hashCode ^
      player1Id.hashCode ^
      player2Id.hashCode ^
      player1Score.hashCode ^
      player2Score.hashCode ^
      winnerId.hashCode ^
      status.hashCode ^
      scheduledTime.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      notes.hashCode ^
      round.hashCode ^
      matchNumber.hashCode ^
      refereeId.hashCode ^
      tableNumber.hashCode ^
      highlights.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
