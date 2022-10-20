part of 'categories_items_by_name_bloc.dart';

abstract class CategoriesItemsByNameEvent extends Equatable {
  const CategoriesItemsByNameEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoriesItemsByNameEvent extends CategoriesItemsByNameEvent {
  final url;

  const FetchCategoriesItemsByNameEvent({
    required this.url,

  });

  @override
  List<Object> get props => [url];
}
