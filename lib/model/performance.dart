import 'dart:convert';

// 'CREATE TABLE IF NOT EXISTS performance (id ITEGER PRIMARY KEY, datePerformed TEXT, exerciseId INTEGER, updatedCount INTEGER, currentResistance INTEGER, repsOrHold INTEGER, splitMultiplier INTEGER)
class Performance {
  final int? id;
  final int? exerciseId;
  final String? datePerformed;
  final int? updatedCount;
  final int? currentResistance;
  final int? repsOrHold;
  final int? splitMultiplier;
  final String? currentTargets;
  Performance({
    this.id,
    this.datePerformed,
    this.exerciseId,
    this.updatedCount,
    this.currentResistance,
    this.repsOrHold,
    this.splitMultiplier,
    this.currentTargets,
  });

  Performance copyWith({
    int? id,
    String? datePerformed,
    int? exerciseId,
    int? updatedCount,
    int? currentResistance,
    int? repsOrHold,
    int? splitMultiplier,
    String? currentTargets,
  }) {
    return Performance(
      id: id ?? this.id,
      datePerformed: datePerformed ?? this.datePerformed,
      exerciseId: exerciseId ?? this.exerciseId,
      updatedCount: updatedCount ?? this.updatedCount,
      currentResistance: currentResistance ?? this.currentResistance,
      repsOrHold: repsOrHold ?? this.repsOrHold,
      splitMultiplier: splitMultiplier ?? this.splitMultiplier,
      currentTargets: currentTargets ?? this.currentTargets,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'datePerformed': datePerformed,
      'exerciseId': exerciseId,
      'updatedCount': updatedCount,
      'currentResistance': currentResistance,
      'repsOrHold': repsOrHold,
      'splitMultiplier': splitMultiplier,
      'currentTargets': currentTargets,
    };
  }

  factory Performance.fromMap(Map<String, dynamic> map) {
    return Performance(
      id: map['id'],
      datePerformed: map['datePerformed'],
      exerciseId: map['exerciseId'],
      updatedCount: map['updatedCount'],
      currentResistance: map['currentResistance'],
      repsOrHold: map['repsOrHold'],
      splitMultiplier: map['splitMultiplier'],
      currentTargets: map['currentTargets'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Performance.fromJson(String source) =>
      Performance.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Performance(id: $id, datePerformed: $datePerformed, exerciseId: $exerciseId, updatedCount: $updatedCount, currentResistance: $currentResistance, repsOrHold: $repsOrHold, splitMultiplier: $splitMultiplier, currentTargets: $currentTargets)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Performance &&
        other.id == id &&
        other.datePerformed == datePerformed &&
        other.exerciseId == exerciseId &&
        other.updatedCount == updatedCount &&
        other.currentResistance == currentResistance &&
        other.repsOrHold == repsOrHold &&
        other.splitMultiplier == splitMultiplier &&
        other.currentTargets == currentTargets;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        datePerformed.hashCode ^
        exerciseId.hashCode ^
        updatedCount.hashCode ^
        currentResistance.hashCode ^
        repsOrHold.hashCode ^
        splitMultiplier.hashCode ^
        currentTargets.hashCode;
  }
}
