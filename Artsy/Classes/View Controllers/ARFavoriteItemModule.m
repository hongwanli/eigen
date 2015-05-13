#import "ARFavoriteItemModule.h"
#import "ARFavoriteItemViewCell.h"

@implementation ARFavoriteItemModule

- (instancetype)init
{
    self = [super init];
    if (!self) {return nil;}
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat sideMargin = [UIDevice isPad] ? 50 : 20;
    layout.sectionInset = UIEdgeInsetsMake(20, sideMargin, 20, sideMargin);
    layout.minimumInteritemSpacing = sideMargin;
    _moduleLayout = layout;
    return self;
}

- (void)resetLayoutItemSizeWithSize:(CGSize)size
{
    self.moduleLayout.itemSize = [ARFavoriteItemViewCell sizeForCellwithSize:size layout:self.moduleLayout];
}

- (Class)classForCell
{
    return [ARFavoriteItemViewCell class];
}

- (ARFeedItemImageSize)imageSize
{
    return ARFeedItemImageSizeLarge;
}

@end
