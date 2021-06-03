import 'dart:convert';

abstract class ExerciseModel {
  ExerciseModel(
      {this.id,
      this.totalCount,
      this.name,
      this.countForSets,
      this.targets,
      this.resistance,
      this.equipment,
      this.steps,
      this.style,
      this.notes});
  final int? id;
  final int? totalCount;
  final String? name;
  final int? countForSets;
  final String? targets;
  final int? resistance;
  final String? equipment;
  final int? steps;
  final String? style;
  final String? notes;

  Map<String, bool> mapTargets();
}

class Exercise extends ExerciseModel {
  final int? id;
  int? totalCount;
  String? name;
  int? countForSets;
  String? targets;
  int? resistance;
  String? equipment;
  int? steps;
  String? style;
  String? notes;

  Exercise(
      {this.id,
      this.totalCount,
      this.name,
      this.countForSets,
      this.targets,
      this.resistance,
      this.equipment,
      this.steps,
      this.style,
      this.notes}) {
    totalCount = totalCount ?? 0;
    name = name ?? '';
    countForSets = countForSets ?? 0;
    targets = targets ?? '';
    resistance = resistance ?? 0;
    equipment = equipment ?? '';
    steps = steps ?? 0;
    style = style ?? '';
    notes = notes ?? '';
  }

  Exercise copyWith({
    int? id,
    int? totalCount,
    String? name,
    int? countForSets,
    String? targets,
    int? resistance,
    String? equipment,
    int? steps,
    String? style,
    String? notes,
  }) {
    return Exercise(
      id: id ?? this.id,
      totalCount: totalCount ?? this.totalCount,
      name: name ?? this.name,
      countForSets: countForSets ?? this.countForSets,
      targets: targets ?? this.targets,
      resistance: resistance ?? this.resistance,
      equipment: equipment ?? this.equipment,
      steps: steps ?? this.steps,
      style: style ?? this.style,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'totalCount': totalCount,
      'name': name,
      'countForSets': countForSets,
      'targets': targets,
      'resistance': resistance,
      'equipment': equipment,
      'steps': steps,
      'style': style,
      'notes': notes,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      totalCount: map['totalCount'],
      name: map['name'],
      countForSets: map['countForSets'],
      targets: map['targets'],
      resistance: map['resistance'],
      equipment: map['equipment'],
      steps: map['steps'],
      style: map['style'],
      notes: map['notes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Exercise.fromJson(String source) =>
      Exercise.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Exercise(id: $id, totalCount: $totalCount, name: $name, countForSets: $countForSets, targets: $targets, resistance: $resistance, equipment: $equipment, steps: $steps, style: $style, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Exercise &&
        other.id == id &&
        other.totalCount == totalCount &&
        other.name == name &&
        other.countForSets == countForSets &&
        other.targets == targets &&
        other.resistance == resistance &&
        other.equipment == equipment &&
        other.steps == steps &&
        other.style == style &&
        other.notes == notes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        totalCount.hashCode ^
        name.hashCode ^
        countForSets.hashCode ^
        targets.hashCode ^
        resistance.hashCode ^
        equipment.hashCode ^
        steps.hashCode ^
        style.hashCode ^
        notes.hashCode;
  }

  @override
  Map<String, bool> mapTargets() {
    // if(targets==null)return;
    Map<String, bool> parsedTargets = {};
    targets!.contains('armsTargetInner')
        ? parsedTargets.addAll(<String, bool>{'armsTargetInner': true})
        : parsedTargets.addAll(<String, bool>{'armsTargetInner': false});

    return parsedTargets;
  }
}
