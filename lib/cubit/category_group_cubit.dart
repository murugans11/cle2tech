import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/repository/home_repository.dart';
import '../models/categoriesbyname/categorieItems.dart';
import '../models/feature/feature_productes.dart';

part 'category_groupe_state.dart';

class CategoryGroupCubit extends Cubit<CategoryGroupItemState> {

  CategoryGroupCubit({required this.homeRepository}) : super(CategoryGroupInitial());

  final HomeRepository homeRepository;

  void loadSingleCategory(String url, int page) {
    if (state is CategoryGroupLoading) return;

    final currentState = state;

    CategorieItems categoryItems = CategorieItems(listingProduct: []);
    var oldSingleCategory = categoryItems;
    if (currentState is CategoryGroupLoaded) {
      oldSingleCategory = currentState.posts;
    }

    emit(CategoryGroupLoading(oldSingleCategory, isFirstFetch: page == 1));

    homeRepository.getCategoryProductListByName('$url$page').then((newPosts) {

      final posts = (state as CategoryGroupLoading).oldPosts;

      if (page == 1) {
        posts.listingProduct.clear();
      }

      List<ListingProduct> listingProduct = newPosts.listingProduct;

      posts.listingProduct.addAll(listingProduct);

      emit(CategoryGroupLoaded(posts: posts));

    });
  }
}
