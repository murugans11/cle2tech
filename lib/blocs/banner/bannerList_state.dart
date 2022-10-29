
import 'package:equatable/equatable.dart';
import 'package:shopeein/models/banner/banner.dart';

import '../../utils/device/custom_error.dart';
import '../../utils/dio/network_call_status_enum.dart';
class BannerState extends Equatable {

  final NetworkCallStatusEnum status;
  final BannerList bannerList;
  final CustomError error;

  const BannerState({
    required this.status,
    required this.bannerList,
    required this.error,
  });

  factory BannerState.initial() {
    return BannerState(
      status: NetworkCallStatusEnum.initial,
      bannerList: BannerList.initial(),
      error: const CustomError(),
    );
  }

  @override
  List<Object> get props => [status, bannerList, error];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'BannerState{status: $status, categoryList: $bannerList, error: $error}';
  }

  BannerState copyWith({
    NetworkCallStatusEnum? status,
    BannerList? categoryList,
    CustomError? error,
  }) {
    return BannerState(
      status: status ?? this.status,
      bannerList: categoryList ?? bannerList,
      error: error ?? this.error,
    );
  }
}
