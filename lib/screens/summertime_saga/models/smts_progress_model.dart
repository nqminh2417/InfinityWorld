import 'dart:convert';

class SmtsProgressModel {
  final String? version;
  final Totals? totals;
  final Issues? issues;
  final Depts? depts;
  SmtsProgressModel({this.version, this.totals, this.issues, this.depts});

  SmtsProgressModel copyWith({String? version, Totals? totals, Issues? issues, Depts? depts}) {
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
      version: map['version'] != null ? map['version'] as String : null,
      totals: map['totals'] != null ? Totals.fromMap(map['totals'] as Map<String, dynamic>) : null,
      issues: map['issues'] != null ? Issues.fromMap(map['issues'] as Map<String, dynamic>) : null,
      depts: map['depts'] != null ? Depts.fromMap(map['depts'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SmtsProgressModel.fromJson(String source) =>
      SmtsProgressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SmtsProgressModel(version: $version, totals: $totals, issues: $issues, depts: $depts)';
  }

  @override
  bool operator ==(covariant SmtsProgressModel other) {
    if (identical(this, other)) return true;

    return other.version == version && other.totals == totals && other.issues == issues && other.depts == depts;
  }

  @override
  int get hashCode {
    return version.hashCode ^ totals.hashCode ^ issues.hashCode ^ depts.hashCode;
  }
}

class Depts {
  final Totals? art;
  final Totals? posing;
  final Totals? dialogue;
  final Totals? code;
  final Totals? audio;
  Depts({this.art, this.posing, this.dialogue, this.code, this.audio});

  Depts copyWith({Totals? art, Totals? posing, Totals? dialogue, Totals? code, Totals? audio}) {
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
      art: map['art'] != null ? Totals.fromMap(map['art'] as Map<String, dynamic>) : null,
      posing: map['posing'] != null ? Totals.fromMap(map['posing'] as Map<String, dynamic>) : null,
      dialogue: map['dialogue'] != null ? Totals.fromMap(map['dialogue'] as Map<String, dynamic>) : null,
      code: map['code'] != null ? Totals.fromMap(map['code'] as Map<String, dynamic>) : null,
      audio: map['audio'] != null ? Totals.fromMap(map['audio'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Depts.fromJson(String source) => Depts.fromMap(json.decode(source) as Map<String, dynamic>);

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
    return art.hashCode ^ posing.hashCode ^ dialogue.hashCode ^ code.hashCode ^ audio.hashCode;
  }
}

class Totals {
  final int? totalsNew;
  final int? closed;
  final int? working;
  final int? total;
  final Percent? percent;
  Totals({this.totalsNew, this.closed, this.working, this.total, this.percent});

  Totals copyWith({int? totalsNew, int? closed, int? working, int? total, Percent? percent}) {
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
      totalsNew: map['totalsNew'] != null ? map['totalsNew'] as int : null,
      closed: map['closed'] != null ? map['closed'] as int : null,
      working: map['working'] != null ? map['working'] as int : null,
      total: map['total'] != null ? map['total'] as int : null,
      percent: map['percent'] != null ? Percent.fromMap(map['percent'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Totals.fromJson(String source) => Totals.fromMap(json.decode(source) as Map<String, dynamic>);

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
    return totalsNew.hashCode ^ closed.hashCode ^ working.hashCode ^ total.hashCode ^ percent.hashCode;
  }
}

class Percent {
  final String? completed;
  final String? working;
  Percent({this.completed, this.working});

  Percent copyWith({String? completed, String? working}) {
    return Percent(completed: completed ?? this.completed, working: working ?? this.working);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'completed': completed, 'working': working};
  }

  factory Percent.fromMap(Map<String, dynamic> map) {
    return Percent(
      completed: map['completed'] != null ? map['completed'] as String : null,
      working: map['working'] != null ? map['working'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Percent.fromJson(String source) => Percent.fromMap(json.decode(source) as Map<String, dynamic>);

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
    return Issues(open: open ?? this.open, closed: closed ?? this.closed, total: total ?? this.total);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'open': open, 'closed': closed, 'total': total};
  }

  factory Issues.fromMap(Map<String, dynamic> map) {
    return Issues(
      open: map['open'] != null ? map['open'] as int : null,
      closed: map['closed'] != null ? map['closed'] as int : null,
      total: map['total'] != null ? map['total'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Issues.fromJson(String source) => Issues.fromMap(json.decode(source) as Map<String, dynamic>);

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
