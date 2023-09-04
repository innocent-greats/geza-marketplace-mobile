

import 'package:nft_market_place/models/reviews.dart';
import 'package:nft_market_place/services/provider.dart';

class ReviewRepository {
  StoreProvider storeProvider;
  ReviewRepository({required this.storeProvider});

  List<StoreReviews> readReviews() => storeProvider.readReviews();
  void writeReviews(List<StoreReviews> reviews) =>
      storeProvider.writeReview(reviews);
}
