import 'package:equatable/equatable.dart';

class TodoTaskModel extends Equatable {
  final String id;
  final String value;
  final bool isDeleting;
  final bool isFavourite;

  const TodoTaskModel({
    required this.id,
    required this.value,
    this.isDeleting = false,
    this.isFavourite = false,
  });

  TodoTaskModel copyWith({
    String? id,
    String? value,
    bool? isDeleting,
    bool? isFavourite,
  }) {
    return TodoTaskModel(
      id: id ?? this.id,
      value: value ?? this.value,
      isDeleting: isDeleting ?? this.isDeleting,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  factory TodoTaskModel.fromMap(Map<String, dynamic> map) {
    return TodoTaskModel(
      id: map['id'],
      value: map['value'],
      isDeleting: map['isDeleting'] == 1,
      isFavourite: map['isFavourite'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'isDeleting': isDeleting ? 1 : 0,
      'isFavourite': isFavourite ? 1 : 0,
    };
  }

  @override
  List<Object?> get props => [id, value, isDeleting, isFavourite];
}