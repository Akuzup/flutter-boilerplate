import 'message_completion.dart';

class Conversation {
  final int createdAt;
  final int updatedAt;
  final String model;
  final List<MessageCompletion> messages;
  final String title;
  final String id;

  Conversation(
    this.id, {
    required this.createdAt,
    required this.model,
    required this.messages,
    required this.title,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'createdAt': createdAt});
    result.addAll({'updatedAt': updatedAt});
    result.addAll({'model': model});
    result.addAll({'messages': messages.map((x) => x.toJson()).toList()});
    result.addAll({'title': title});
    result.addAll({'id': id});

    return result;
  }

  factory Conversation.fromJson(Map<String, dynamic> map) {
    return Conversation(
      map['id'].toString(),
      createdAt: num.tryParse(map['createdAt'].toString())?.toInt() ?? 0,
      updatedAt: num.tryParse(map['updatedAt'].toString())?.toInt() ??
          num.tryParse(map['createdAt'].toString())?.toInt() ??
          0,
      model: map['model'].toString(),
      messages: map['messages'] != null && map['messages'] is List
          ? List<MessageCompletion>.from(map['messages']?.map(
              (x) => MessageCompletion.fromJson(Map<String, dynamic>.from(x))))
          : <MessageCompletion>[],
      title: map['title'] ?? '',
    );
  }

  Conversation copyWith({
    int? createdAt,
    String? model,
    List<MessageCompletion>? messages,
    String? title,
  }) {
    return Conversation(
      id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      model: model ?? this.model,
      messages: messages ?? this.messages,
      title: title ?? this.title,
    );
  }
}
