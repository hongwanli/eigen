#import "ARModelCollectionViewModule.h"

@interface ARFavoriteItemModule : ARModelCollectionViewModule
@property (nonatomic, strong) UICollectionViewFlowLayout *moduleLayout;
- (void)resetLayoutItemSizeWithSize:(CGSize)size;
@end
