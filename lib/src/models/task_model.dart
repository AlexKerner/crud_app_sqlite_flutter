import 'dart:convert';

class TaskModel {
  final int? id;
  final String content;
  late final int status;

  TaskModel({
    this.id,
    required this.content,
    required this.status,
  });

  TaskModel copyWith({
    int? id,
    String? content,
    int? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      content: content ?? this.content,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'content': content,
      'status': status,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] != null ? map['id'] as int : null,
      content: map['content'] as String,
      status: map['status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TaskModel(id: $id, content: $content, status: $status)';

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.content == content && other.status == status;
  }

  @override
  int get hashCode => id.hashCode ^ content.hashCode ^ status.hashCode;
}
