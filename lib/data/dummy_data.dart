import 'package:ecommerce_application_fullsatck_v2/features/shop/models/banner_model.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/brand_model.dart';
import 'package:ecommerce_application_fullsatck_v2/features/shop/models/category_model.dart';
import 'package:ecommerce_application_fullsatck_v2/routes/routes.dart';
import 'package:ecommerce_application_fullsatck_v2/utils/constants/image.dart';

class AppDummyModel {
  /// List of all Banners

  static final List<BannerModel> banner = [
    BannerModel(
      imageUrl: AppImages.homeBanner1,
      targetScreen: Routes.order,
      active: true,
    ),
    BannerModel(
      imageUrl: AppImages.homeBanner2,
      targetScreen: Routes.cart,
      active: true,
    ),
    BannerModel(
      imageUrl: AppImages.homeBanner3,
      targetScreen: Routes.wishlist,
      active: true,
    ),
    BannerModel(
      imageUrl: AppImages.homeBanner4,
      targetScreen: Routes.productDetail,
      active: true,
    ),
    BannerModel(
      imageUrl: AppImages.homeBanner5,
      targetScreen: Routes.allProducts,
      active: true,
    ),
  ];

  /// List of all Categories
  static final List<CategoryModel> categories = [
    /// Parent Categories
    CategoryModel(
      id: '1',
      name: 'Clothes',
      image: AppImages.clothesIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '2',
      name: 'Shoes',
      image: AppImages.shoesIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '3',
      name: 'Cosmetics',
      image: AppImages.cosmeticsIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '4',
      name: 'Electronics',
      image: AppImages.electronicsIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '5',
      name: 'Furniture',
      image: AppImages.furnitureIcon,
      isFeatured: true,
    ),
    CategoryModel(
      id: '6',
      name: 'Sports',
      image: AppImages.sportsIcon,
      isFeatured: true,
    ),

    /// Clothes
    CategoryModel(
      id: '7',
      name: 'Shirts',
      image: AppImages.shirtIcon,
      parentId: '1',
    ),
    CategoryModel(
      id: '8',
      name: 'Jackets',
      image: AppImages.jacketsIcon,
      parentId: '1',
    ),
    CategoryModel(
      id: '9',
      name: 'Shorts',
      image: AppImages.shortsIcon,
      parentId: '1',
    ),

    /// Shoes
    CategoryModel(
      id: '10',
      name: 'Formal Shoes',
      image: AppImages.formalShoesIcon,
      parentId: '2',
    ),
    CategoryModel(
      id: '11',
      name: 'Sports Shoes',
      image: AppImages.sportsShoesIcon,
      parentId: '2',
    ),

    /// Cosmetics
    CategoryModel(
      id: '12',
      name: 'Face',
      image: AppImages.faceIcon,
      parentId: '3',
    ),
    CategoryModel(
      id: '13',
      name: 'Hair Oils',
      image: AppImages.hairOilIcon,
      parentId: '3',
    ),
    CategoryModel(
      id: '14',
      name: 'Bags',
      image: AppImages.bagsIcon,
      parentId: '3',
    ),
    CategoryModel(
      id: '15',
      name: 'Perfumes',
      image: AppImages.perfumeIcon,
      parentId: '3',
    ),
    CategoryModel(
      id: '16',
      name: 'Watches',
      image: AppImages.watchIcon,
      parentId: '3',
    ),

    /// Electronics
    CategoryModel(
      id: '17',
      name: 'Gadgets',
      image: AppImages.gadgetsIcon,
      parentId: '4',
      isFeatured: false,
    ),
    CategoryModel(
      id: '18',
      name: 'Laptops',
      image: AppImages.laptopsIcon,
      parentId: '4',
      isFeatured: false,
    ),
    CategoryModel(
      id: '19',
      name: 'Mobiles',
      image: AppImages.mobileIcon,
      parentId: '4',
      isFeatured: false,
    ),

    /// Furniture
    CategoryModel(
      id: '20',
      name: 'Bed',
      image: AppImages.bedIcon,
      parentId: '5',
      isFeatured: false,
    ),
    CategoryModel(
      id: '21',
      name: 'Lamps',
      image: AppImages.lampIcon,
      parentId: '5',
      isFeatured: false,
    ),

    /// Sports
    CategoryModel(
      id: '22',
      name: 'Cricket',
      image: AppImages.cricketIcon,
      parentId: '6',
      isFeatured: false,
    ),
    CategoryModel(
      id: '23',
      name: 'Soccer',
      image: AppImages.soccerIcon,
      parentId: '6',
      isFeatured: false,
    ),
  ];

  /// List of all Brands
  static final List<BrandModel> brands = [
    BrandModel(
      id: '1',
      image: AppImages.nikeLogo,
      name: 'Nike',
      productsCount: 2,
      isFeatured: true,
    ),
    BrandModel(
      id: '2',
      image: AppImages.adidasLogo,
      name: 'Adidas',
      productsCount: 2,
      isFeatured: true,
    ),
    BrandModel(
      id: '3',
      image: AppImages.appleLogo,
      name: 'Apple',
      productsCount: 8,
      isFeatured: true,
    ),
    BrandModel(
      id: '4',
      image: AppImages.bataLogo,
      name: 'Bata',
      productsCount: 4,
      isFeatured: true,
    ),
    BrandModel(
      id: '5',
      image: AppImages.bloodyLogo,
      name: 'Bloody',
      productsCount: 9,
      isFeatured: false,
    ),
    BrandModel(
      id: '6',
      image: AppImages.breakoutLogo,
      name: 'Breakout',
      productsCount: 7,
      isFeatured: true,
    ),
    BrandModel(
      id: '7',
      image: AppImages.dariMoochLogo,
      name: 'Dari Mooch',
      productsCount: 4,
      isFeatured: true,
    ),
    BrandModel(
      id: '8',
      image: AppImages.interWoodLogo,
      name: 'Interwood',
      productsCount: 9,
      isFeatured: false,
    ),
    BrandModel(
      id: '9',
      image: AppImages.hpLogo,
      name: 'HP',
      productsCount: 4,
      isFeatured: false,
    ),
    BrandModel(
      id: '10',
      image: AppImages.jLogo,
      name: 'J.',
      productsCount: 8,
      isFeatured: true,
    ),
    BrandModel(
      id: '11',
      image: AppImages.nDURELogo,
      name: 'NDURE',
      productsCount: 4,
      isFeatured: true,
    ),
    BrandModel(
      id: '12',
      image: AppImages.northStarLogo,
      name: 'NorthStar',
      productsCount: 2,
      isFeatured: true,
    ),
    BrandModel(
      id: '13',
      image: AppImages.poloLogo,
      name: 'Polo',
      productsCount: 2,
      isFeatured: true,
    ),
  ];
}
