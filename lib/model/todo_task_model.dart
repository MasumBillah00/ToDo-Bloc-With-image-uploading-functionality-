

import 'package:equatable/equatable.dart';

class TodoTaskModelModel extends Equatable{

  const TodoTaskModelModel({
    required this.id,
    required this.value,
    this.isDeleting = false,
    this.isFavourite =false,
  });


  final String id;
  final String value;
  final bool isDeleting;
  final bool isFavourite;

  TodoTaskModelModel copyWith({ String?id, String? value, bool? isDeleting, bool?isFavourite}){
    return TodoTaskModelModel(
      id: id?? this.id,
      value: value?? this.value,
      isDeleting: isDeleting?? this.isDeleting,
      isFavourite: isFavourite?? this.isFavourite,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, value, isDeleting, isFavourite];

}