import 'package:bloc/bloc.dart';
import 'package:shopeein/cubit/cart/single_category_group/single_category_items_state.dart';



import '../../../data/repository/home_repository.dart';
import '../../../models/categoriesbyname/categorieItems.dart';
import '../../../models/feature/feature_productes.dart';



class SingleCategoryCubit extends Cubit<SingleCategoryItemState> {

  SingleCategoryCubit({required this.homeRepository}) : super(SingleCategoryInitial());

  final HomeRepository homeRepository;

  void loadSingleCategory(String url, int page) {

    if (state is SingleCategoryLoading) return;

    final currentState = state;

    CategorieItems categoryItems = CategorieItems(listingProduct: []);
    var oldSingleCategory = categoryItems;
    if (currentState is SingleCategoryLoaded) {
      oldSingleCategory = currentState.posts;
    }

    emit(SingleCategoryLoading(oldSingleCategory, isFirstFetch: page == 1));

    homeRepository.getCategoryProductListByName('$url$page').then((newPosts) {

      final posts = (state as SingleCategoryLoading).oldPosts;

     /* if (page == 1) {
        posts.listingProduct.clear();
      }*/

      List<ListingProduct> listingProduct = newPosts.listingProduct;

      posts.listingProduct.addAll(listingProduct);

      emit(SingleCategoryLoaded(posts: posts));

    });
  }
}
