import 'dart:convert';

class Exercise {
  int? id;
  int? count;
  String? name;
  int? countForSets;
  String? targets;
  double? resistance;
  String? equipment;
  int? steps;
  String? style;
  String? notes;

  Exercise([
    this.id,
    this.count,
    this.name,
    this.countForSets,
    this.targets,
    this.resistance,
    this.equipment,
    this.steps,
    this.style,
    this.notes,
  ]);

  Exercise copyWith({
    int? id,
    int? count,
    String? name,
    int? countForSets,
    String? targets,
    double? resistance,
    String? equipment,
    int? steps,
    String? style,
    String? notes,
  }) {
    return Exercise(
      id ?? this.id,
      count ?? this.count,
      name ?? this.name,
      countForSets ?? this.countForSets,
      targets ?? this.targets,
      resistance ?? this.resistance,
      equipment ?? this.equipment,
      steps ?? this.steps,
      style ?? this.style,
      notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'count': count,
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
      map['id'],
      map['count'],
      map['name'],
      map['countForSets'],
      map['targets'],
      map['resistance'],
      map['equipment'],
      map['steps'],
      map['style'],
      map['notes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Exercise.fromJson(String source) =>
      Exercise.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Exercise(id: $id, count: $count, name: $name, countForSets: $countForSets, targets: $targets, resistance: $resistance, equipment: $equipment, steps: $steps, style: $style, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Exercise &&
        other.id == id &&
        other.count == count &&
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
        count.hashCode ^
        name.hashCode ^
        countForSets.hashCode ^
        targets.hashCode ^
        resistance.hashCode ^
        equipment.hashCode ^
        steps.hashCode ^
        style.hashCode ^
        notes.hashCode;
  }
}

enum ExerciseStyle {
  areobic,
  anareobic,
  isometric,
  plyometric,
  strength,
}

abstract class Target {
  bool? innerIsTargeted;
  bool? outerIsTargeted;
  bool? upperIsTargeted;
  bool? lowerIsTargeted;

  Target({
    this.innerIsTargeted,
    this.outerIsTargeted,
    this.upperIsTargeted,
    this.lowerIsTargeted,
  });
  bool targetInner(bool targetInner);
  bool targetOuter(bool targetOuter);
  bool targetUpper(bool targetUpper);
  bool targetLower(bool targetLower);
  void targetAll();
  Target copyWith();
  Target.notTargeted() {
    innerIsTargeted = false;
  }
}

class Arms extends Target {
  Arms(
    this.innerIsTargeted,
    this.outerIsTargeted,
    this.upperIsTargeted,
    this.lowerIsTargeted,
  ) : super(
          innerIsTargeted: innerIsTargeted,
          outerIsTargeted: outerIsTargeted,
          upperIsTargeted: upperIsTargeted,
          lowerIsTargeted: lowerIsTargeted,
        );

  bool? innerIsTargeted;

  bool? outerIsTargeted;

  bool? upperIsTargeted;

  bool? lowerIsTargeted;

  @override
  bool targetInner(bool e) => innerIsTargeted = e;

  @override
  bool targetOuter(bool e) => outerIsTargeted = e;

  @override
  bool targetUpper(bool e) => upperIsTargeted = e;

  @override
  bool targetLower(bool e) => lowerIsTargeted = e;

  void targetAll() {
    innerIsTargeted = true;
    outerIsTargeted = true;
    upperIsTargeted = true;
    lowerIsTargeted = true;
  }

  @override
  Target copyWith({
    bool? innerIsTargeted,
    bool? outerIsTargeted,
    bool? upperIsTargeted,
    bool? lowerIsTargeted,
  }) {
    return Arms(
        innerIsTargeted ?? this.innerIsTargeted,
        outerIsTargeted ?? this.outerIsTargeted,
        upperIsTargeted ?? this.upperIsTargeted,
        lowerIsTargeted ?? this.lowerIsTargeted);
  }
}
