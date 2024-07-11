import 'package:equatable/equatable.dart';

class TodoTaskModel extends Equatable {
  final String id;
  final String value;
  final String description;
  final bool isFavourite;
  final bool isDeleting;

  const TodoTaskModel({
    required this.id,
    required this.value,
    required this.description,
    this.isFavourite = false,
    this.isDeleting = false,
  });

  TodoTaskModel copyWith({
    String? id,
    String? value,
    String? description,
    bool? isFavourite,
    bool? isDeleting,
  }) {
    return TodoTaskModel(
      id: id ?? this.id,
      value: value ?? this.value,
      description: description ?? this.description,
      isFavourite: isFavourite ?? this.isFavourite,
      isDeleting: isDeleting ?? this.isDeleting,
    );
  }

  factory TodoTaskModel.fromMap(Map<String, dynamic> map) {
    return TodoTaskModel(
      id: map['id'],
      value: map['value'],
      description: map['description'], // Ensure this line is present
      isDeleting: map['isDeleting'] == 1,
      isFavourite: map['isFavourite'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'description': description, // Ensure this line is present
      'isDeleting': isDeleting ? 1 : 0,
      'isFavourite': isFavourite ? 1 : 0,
    };
  }

  @override
  List<Object?> get props => [id, value, description, isFavourite, isDeleting];
}
