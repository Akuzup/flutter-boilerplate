class MessageCompletion {
  final String content;
  final String role;
  late final int createdAt;

  MessageCompletion(this.content, this.role, {int? createdAt}) {
    this.createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch;
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'content': content});
    result.addAll({'role': role});
    result.addAll({'createdAt': createdAt});

    return result;
  }

  factory MessageCompletion.fromJson(Map<String, dynamic> map) {
    return MessageCompletion(
      map['content'] ?? '',
      map['role'].toString(),
      createdAt: map['createdAt'] ?? DateTime.now().millisecondsSinceEpoch,
    );
  }

  MessageCompletion copyWith({
    String? content,
    String? role,
    int? createdAt,
  }) {
    return MessageCompletion(
      content ?? this.content,
      role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
