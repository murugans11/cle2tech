part of 'feature_product_list_bloc.dart';

class FeatureProductListState extends Equatable {

  final NetworkCallStatusEnum status;
  final FeatureProductList featureProductList;
  final CustomError error;

  const FeatureProductListState({
    required this.status,
    required this.featureProductList,
    required this.error,
  });

  factory FeatureProductListState.initial() {
    return FeatureProductListState(
      status: NetworkCallStatusEnum.initial,
      featureProductList: FeatureProductList.initial(),
      error: const CustomError(),
    );
  }

  @override
  List<Object> get props => [status, featureProductList, error];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'FeatureProductListState{status: $status, listingProducts: $featureProductList, error: $error}';
  }

  FeatureProductListState copyWith({
    NetworkCallStatusEnum? status,
    FeatureProductList? featureProductLists,
    CustomError? error,
  }) {
    return FeatureProductListState(
      status: status ?? this.status,
      featureProductList: featureProductLists ?? featureProductList,
      error: error ?? this.error,
    );
  }
}
