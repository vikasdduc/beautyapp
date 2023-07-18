import 'package:glamcode/data/model/packages_model/category.dart';
import 'package:glamcode/data/model/packages_model/packages_category.dart';

PackagesCategory categoryToPackagesCategory(Category category) {
  return PackagesCategory(
    id: category.id,
    mainCategoryId: category.mainCategoryId,
    name: category.name,
    slug: category.slug,
    image: category.image,
    status: category.status,
    sortOrder: category.sortOrder,
    createdAt: category.createdAt,
    updatedAt: category.updatedAt,
    ratingPer: category.ratingPer,
    ratingPop: category.ratingPop,
    categoryImageUrl: category.categoryImageUrl,
  );
}
