part of 'feature_product_list_bloc.dart';

abstract class FeatureProductListEvent extends Equatable {
  const FeatureProductListEvent();

  @override
  List<Object> get props => [];
}

class FetchFeatureProductItemsEvent extends FeatureProductListEvent {
  const FetchFeatureProductItemsEvent();
}
