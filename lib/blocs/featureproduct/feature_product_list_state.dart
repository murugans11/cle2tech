part of 'feature_product_list_bloc.dart';



// Define states
abstract class FeatureProductListState extends Equatable {
  const FeatureProductListState();

  @override
  List<Object> get props => [];
}

class FeatureProductListInitial extends FeatureProductListState {
  const FeatureProductListInitial();
  factory FeatureProductListInitial.initial() {
    return FeatureProductListInitial();
  }
}

class FeatureProductListLoading extends FeatureProductListState {
  const FeatureProductListLoading();
  @override
  List<Object> get props => [];
}

class FeatureProductListLoaded extends FeatureProductListState {

  final FeatureProductList featureProductList;


  const FeatureProductListLoaded({

    required this.featureProductList,

  });

  @override
  List<Object> get props => [featureProductList];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'FeatureProductListState{status:  listingProducts: $featureProductList, }';
  }

  FeatureProductListState copyWith({
    FeatureProductList? featureProductLists,

  }) {
    return FeatureProductListLoaded(
      featureProductList: featureProductLists ?? featureProductList,
    );
  }

}

class FeatureProductListError extends FeatureProductListState {
  final String message;

  const FeatureProductListError({required this.message});

  @override
  List<Object> get props => [message];
}

