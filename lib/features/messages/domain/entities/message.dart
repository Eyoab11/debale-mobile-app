class Message {
  final String id;
  final String matchId;
  final String senderId;
  final String content;
  final bool isRead;
  final DateTime? readAt;
  final DateTime createdAt;

  const Message({
    required this.id,
    required this.matchId,
    required this.senderId,
    required this.content,
    this.isRead = false,
    this.readAt,
    required this.createdAt,
  });

  // Factory constructor from Supabase data
  factory Message.fromSupabase(Map<String, dynamic> data) {
    return Message(
      id: data['id'] ?? '',
      matchId: data['match_id'] ?? '',
      senderId: data['sender_id'] ?? '',
      content: data['content'] ?? '',
      isRead: data['is_read'] ?? false,
      readAt: data['read_at'] != null 
          ? DateTime.parse(data['read_at'])
          : null,
      createdAt: DateTime.parse(data['created_at']),
    );
  }

  // Convert to Supabase data
  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'match_id': matchId,
      'sender_id': senderId,
      'content': content,
      'is_read': isRead,
      'read_at': readAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  Message copyWith({
    String? id,
    String? matchId,
    String? senderId,
    String? content,
    bool? isRead,
    DateTime? readAt,
    DateTime? createdAt,
  }) {
    return Message(
      id: id ?? this.id,
      matchId: matchId ?? this.matchId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
} 