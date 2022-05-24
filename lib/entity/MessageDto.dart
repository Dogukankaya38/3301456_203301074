class MessageDto {
  final int id;
  final String name;

  const MessageDto({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  MessageDto.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];
}
