
import 'package:equatable/equatable.dart';
import 'package:shopeein/models/banner/banner.dart';




// Define states
abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

class BannerInitial extends BannerState {
  const BannerInitial();
  factory BannerInitial.initial() {
    return const BannerInitial();
  }
}

class BannerLoading extends BannerState {
  const BannerLoading();
  @override
  List<Object> get props => [];
}

class BannerLoaded extends BannerState {

  final BannerList bannerList;

  const BannerLoaded({required this.bannerList});


  BannerState copyWith({
    BannerList? categoryList,
  }) {
    return BannerLoaded(
      bannerList: categoryList ?? bannerList,
    );
  }

  @override
  List<Object> get props => [bannerList];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'BannerState{categoryList: $bannerList, }';
  }

}

class BannerError extends BannerState {
  final String message;

   const BannerError({required this.message});

  @override
  List<Object> get props => [message];
}


