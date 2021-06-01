import 'dart:convert';

class ExerciseModel {}

class Exercise {
  final int? id;
  final int? totalCount;
  final String? name;

  Exercise(this.id, this.totalCount, this.name);

  Exercise copyWith({
    int? id,
    int? totalCount,
    String? name,
  }) {
    return Exercise(
      id ?? this.id,
      totalCount ?? this.totalCount,
      name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'totalCount': totalCount,
      'name': name,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      map['_id'] ?? 0,
      map['totalCount'] ?? 0,
      map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Exercise.fromJson(String source) =>
      Exercise.fromMap(json.decode(source));

  @override
  String toString() =>
      'Exercise(id: $id, totalCount: $totalCount, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Exercise &&
        other.id == id &&
        other.totalCount == totalCount &&
        other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ totalCount.hashCode ^ name.hashCode;
}
// / class Exercise {
//   final int? id;
//   final int? totalCount;
//   final String? name;
//   final int? countForSets;
//   final String? targets;
//   final int? resistance;
//   final String? equipment;
//   final int? steps;
//   final String? style;
//   final String? notes;

//   Exercise({
//     this.id,
//     this.totalCount,
//     this.name,
//     this.countForSets,
//     this.targets,
//     this.resistance,
//     this.equipment,
//     this.steps,
//     this.style,
//     this.notes,
//   });

//   Exercise copyWith({
//     int? id,
//     int? totalCount,
//     String? name,
//     int? countForSets,
//     String? targets,
//     int? resistance,
//     String? equipment,
//     int? steps,
//     String? style,
//     String? notes,
//   }) {
//     return Exercise(
//       id: id ?? this.id,
//       totalCount: totalCount ?? this.totalCount,
//       name: name ?? this.name,
//       countForSets: countForSets ?? this.countForSets,
//       targets: targets ?? this.targets,
//       resistance: resistance ?? this.resistance,
//       equipment: equipment ?? this.equipment,
//       steps: steps ?? this.steps,
//       style: style ?? this.style,
//       notes: notes ?? this.notes,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'totalCount': totalCount,
//       'name': name,
//       'countForSets': countForSets,
//       'targets': targets,
//       'resistance': resistance,
//       'equipment': equipment,
//       'steps': steps,
//       'style': style,
//       'notes': notes,
//     };
//   }

//   factory Exercise.fromMap(Map<String, dynamic> map) {
//     return Exercise(
//       id: map['id'],
//       totalCount: map['totalCount'],
//       name: map['name'],
//       countForSets: map['countForSets'],
//       targets: map['targets'],
//       resistance: map['resistance'],
//       equipment: map['equipment'],
//       steps: map['steps'],
//       style: map['style'],
//       notes: map['notes'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Exercise.fromJson(String source) =>
//       Exercise.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Exercise(id: $id, totalCount: $totalCount, name: $name, countForSets: $countForSets, targets: $targets, resistance: $resistance, equipment: $equipment, steps: $steps, style: $style, notes: $notes)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is Exercise &&
//         other.id == id &&
//         other.totalCount == totalCount &&
//         other.name == name &&
//         other.countForSets == countForSets &&
//         other.targets == targets &&
//         other.resistance == resistance &&
//         other.equipment == equipment &&
//         other.steps == steps &&
//         other.style == style &&
//         other.notes == notes;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         totalCount.hashCode ^
//         name.hashCode ^
//         countForSets.hashCode ^
//         targets.hashCode ^
//         resistance.hashCode ^
//         equipment.hashCode ^
//         steps.hashCode ^
//         style.hashCode ^
//         notes.hashCode;
//   }
// }

// enum ExerciseStyle {
//   areobic,
//   anareobic,
//   isometric,
//   plyometric,
//   strength,
// }

// abstract class Target {
//   bool? innerIsTargeted;
//   bool? outerIsTargeted;
//   bool? upperIsTargeted;
//   bool? lowerIsTargeted;

//   Target({
//     this.innerIsTargeted,
//     this.outerIsTargeted,
//     this.upperIsTargeted,
//     this.lowerIsTargeted,
//   });
//   bool targetInner(bool targetInner);
//   bool targetOuter(bool targetOuter);
//   bool targetUpper(bool targetUpper);
//   bool targetLower(bool targetLower);
//   void targetAll();
//   Target copyWith();
//   Target.notTargeted() {
//     innerIsTargeted = false;
//   }
// }

// class Arms extends Target {
//   Arms(
//     this.innerIsTargeted,
//     this.outerIsTargeted,
//     this.upperIsTargeted,
//     this.lowerIsTargeted,
//   ) : super(
//           innerIsTargeted: innerIsTargeted,
//           outerIsTargeted: outerIsTargeted,
//           upperIsTargeted: upperIsTargeted,
//           lowerIsTargeted: lowerIsTargeted,
//         );

//   bool? innerIsTargeted;

//   bool? outerIsTargeted;

//   bool? upperIsTargeted;

//   bool? lowerIsTargeted;

//   @override
//   bool targetInner(bool e) => innerIsTargeted = e;

//   @override
//   bool targetOuter(bool e) => outerIsTargeted = e;

//   @override
//   bool targetUpper(bool e) => upperIsTargeted = e;

//   @override
//   bool targetLower(bool e) => lowerIsTargeted = e;

//   void targetAll() {
//     innerIsTargeted = true;
//     outerIsTargeted = true;
//     upperIsTargeted = true;
//     lowerIsTargeted = true;
//   }

//   @override
//   Target copyWith({
//     bool? innerIsTargeted,
//     bool? outerIsTargeted,
//     bool? upperIsTargeted,
//     bool? lowerIsTargeted,
//   }) {
//     return Arms(
//         innerIsTargeted ?? this.innerIsTargeted,
//         outerIsTargeted ?? this.outerIsTargeted,
//         upperIsTargeted ?? this.upperIsTargeted,
//         lowerIsTargeted ?? this.lowerIsTargeted);
//   }
// }
