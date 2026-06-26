import 'dart:convert';

class SmtsProgressModel {
  final String? version;
  final Totals? totals;
  final Issues? issues;
  final Depts? depts;
  SmtsProgressModel({this.version, this.totals, this.issues, this.depts});

  SmtsProgressModel copyWith({
    String? version,
    Totals? totals,
    Issues? issues,
    Depts? depts,
  }) {
    return SmtsProgressModel(
      version: version ?? this.version,
      totals: totals ?? this.totals,
      issues: issues ?? this.issues,
      depts: depts ?? this.depts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'version': version,
      'totals': totals?.toMap(),
      'issues': issues?.toMap(),
      'depts': depts?.toMap(),
    };
  }

  factory SmtsProgressModel.fromMap(Map<String, dynamic> map) {
    return SmtsProgressModel(
      version: _requiredString(map, 'version'),
      totals: Totals.fromMap(_requiredMap(map, 'totals')),
      issues: Issues.fromMap(_requiredMap(map, 'issues')),
      depts: Depts.fromMap(_requiredMap(map, 'depts')),
    );
  }

  String toJson() => json.encode(toMap());

  factory SmtsProgressModel.fromJson(String source) {
    final decoded = json.decode(source);

    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Progress response must be an object');
    }

    return SmtsProgressModel.fromMap(decoded);
  }

  @override
  String toString() {
    return 'SmtsProgressModel(version: $version, totals: $totals, issues: $issues, depts: $depts)';
  }

  @override
  bool operator ==(covariant SmtsProgressModel other) {
    if (identical(this, other)) return true;

    return other.version == version &&
        other.totals == totals &&
        other.issues == issues &&
        other.depts == depts;
  }

  @override
  int get hashCode {
    return version.hashCode ^
        totals.hashCode ^
        issues.hashCode ^
        depts.hashCode;
  }
}

class Depts {
  final Totals? art;
  final Totals? posing;
  final Totals? dialogue;
  final Totals? code;
  final Totals? audio;
  Depts({this.art, this.posing, this.dialogue, this.code, this.audio});

  Depts copyWith({
    Totals? art,
    Totals? posing,
    Totals? dialogue,
    Totals? code,
    Totals? audio,
  }) {
    return Depts(
      art: art ?? this.art,
      posing: posing ?? this.posing,
      dialogue: dialogue ?? this.dialogue,
      code: code ?? this.code,
      audio: audio ?? this.audio,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'art': art?.toMap(),
      'posing': posing?.toMap(),
      'dialogue': dialogue?.toMap(),
      'code': code?.toMap(),
      'audio': audio?.toMap(),
    };
  }

  factory Depts.fromMap(Map<String, dynamic> map) {
    return Depts(
      art: Totals.fromMap(_requiredMap(map, 'art')),
      posing: Totals.fromMap(_requiredMap(map, 'posing')),
      dialogue: Totals.fromMap(_requiredMap(map, 'dialogue')),
      code: Totals.fromMap(_requiredMap(map, 'code')),
      audio: Totals.fromMap(_requiredMap(map, 'audio')),
    );
  }

  String toJson() => json.encode(toMap());

  factory Depts.fromJson(String source) =>
      Depts.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Depts(art: $art, posing: $posing, dialogue: $dialogue, code: $code, audio: $audio)';
  }

  @override
  bool operator ==(covariant Depts other) {
    if (identical(this, other)) return true;

    return other.art == art &&
        other.posing == posing &&
        other.dialogue == dialogue &&
        other.code == code &&
        other.audio == audio;
  }

  @override
  int get hashCode {
    return art.hashCode ^
        posing.hashCode ^
        dialogue.hashCode ^
        code.hashCode ^
        audio.hashCode;
  }
}

class Totals {
  final int? totalsNew;
  final int? closed;
  final int? working;
  final int? total;
  final Percent? percent;
  Totals({this.totalsNew, this.closed, this.working, this.total, this.percent});

  Totals copyWith({
    int? totalsNew,
    int? closed,
    int? working,
    int? total,
    Percent? percent,
  }) {
    return Totals(
      totalsNew: totalsNew ?? this.totalsNew,
      closed: closed ?? this.closed,
      working: working ?? this.working,
      total: total ?? this.total,
      percent: percent ?? this.percent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalsNew': totalsNew,
      'closed': closed,
      'working': working,
      'total': total,
      'percent': percent?.toMap(),
    };
  }

  factory Totals.fromMap(Map<String, dynamic> map) {
    return Totals(
      totalsNew: _optionalInt(map, 'totalsNew'),
      closed: _requiredInt(map, 'closed'),
      working: _requiredInt(map, 'working'),
      total: _requiredInt(map, 'total'),
      percent: Percent.fromMap(_requiredMap(map, 'percent')),
    );
  }

  String toJson() => json.encode(toMap());

  factory Totals.fromJson(String source) =>
      Totals.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Totals(totalsNew: $totalsNew, closed: $closed, working: $working, total: $total, percent: $percent)';
  }

  @override
  bool operator ==(covariant Totals other) {
    if (identical(this, other)) return true;

    return other.totalsNew == totalsNew &&
        other.closed == closed &&
        other.working == working &&
        other.total == total &&
        other.percent == percent;
  }

  @override
  int get hashCode {
    return totalsNew.hashCode ^
        closed.hashCode ^
        working.hashCode ^
        total.hashCode ^
        percent.hashCode;
  }
}

class Percent {
  final String? completed;
  final String? working;
  Percent({this.completed, this.working});

  Percent copyWith({String? completed, String? working}) {
    return Percent(
      completed: completed ?? this.completed,
      working: working ?? this.working,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'completed': completed, 'working': working};
  }

  factory Percent.fromMap(Map<String, dynamic> map) {
    return Percent(
      completed: _requiredString(map, 'completed'),
      working: _requiredString(map, 'working'),
    );
  }

  String toJson() => json.encode(toMap());

  factory Percent.fromJson(String source) =>
      Percent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Percent(completed: $completed, working: $working)';

  @override
  bool operator ==(covariant Percent other) {
    if (identical(this, other)) return true;

    return other.completed == completed && other.working == working;
  }

  @override
  int get hashCode => completed.hashCode ^ working.hashCode;
}

class Issues {
  final int? open;
  final int? closed;
  final int? total;
  Issues({this.open, this.closed, this.total});

  Issues copyWith({int? open, int? closed, int? total}) {
    return Issues(
      open: open ?? this.open,
      closed: closed ?? this.closed,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'open': open, 'closed': closed, 'total': total};
  }

  factory Issues.fromMap(Map<String, dynamic> map) {
    return Issues(
      open: _requiredInt(map, 'open'),
      closed: _requiredInt(map, 'closed'),
      total: _requiredInt(map, 'total'),
    );
  }

  String toJson() => json.encode(toMap());

  factory Issues.fromJson(String source) =>
      Issues.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Issues(open: $open, closed: $closed, total: $total)';

  @override
  bool operator ==(covariant Issues other) {
    if (identical(this, other)) return true;

    return other.open == open && other.closed == closed && other.total == total;
  }

  @override
  int get hashCode => open.hashCode ^ closed.hashCode ^ total.hashCode;
}

Map<String, dynamic> _requiredMap(Map<String, dynamic> map, String key) {
  final value = map[key];

  if (value is Map<String, dynamic>) {
    return value;
  }

  if (value is Map) {
    return Map<String, dynamic>.from(value);
  }

  throw FormatException('Missing or invalid "$key" object');
}

int _requiredInt(Map<String, dynamic> map, String key) {
  final value = map[key];

  if (value is int) {
    return value;
  }

  throw FormatException('Missing or invalid "$key" integer');
}

int? _optionalInt(Map<String, dynamic> map, String key) {
  final value = map[key];

  if (value == null) {
    return null;
  }

  if (value is int) {
    return value;
  }

  throw FormatException('Invalid "$key" integer');
}

String _requiredString(Map<String, dynamic> map, String key) {
  final value = map[key];

  if (value is String && value.isNotEmpty) {
    return value;
  }

  throw FormatException('Missing or invalid "$key" string');
}
