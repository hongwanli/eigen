@interface ARFavoriteItemViewCell : UICollectionViewCell

+ (CGSize)sizeForCellwithSize:(CGSize)size layout:(UICollectionViewFlowLayout *)layout;
- (void)setupWithRepresentedObject:(id)object;

@end
