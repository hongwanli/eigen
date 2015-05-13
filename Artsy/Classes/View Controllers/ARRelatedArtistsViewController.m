#import "ARRelatedArtistsViewController.h"
#import "ARFavoriteItemViewCell.h"

@interface ARRelatedArtistsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *view;

@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;
// Private Access
@property (nonatomic, strong, readwrite) Fair *fair;

@end

@implementation ARRelatedArtistsViewController

@dynamic view;

- (instancetype)initWithFair:(Fair *)fair {
    self = [super init];
    if (!self) { return nil; }

    self.fair = fair;

    return self;
}

- (void)setRelatedArtists:(NSArray *)relatedArtists
{
    _relatedArtists = relatedArtists;
    [self.view reloadData];
    [self updateHeightConstraint];
}

- (void)updateHeightConstraint
{
    CGFloat height = self.view.collectionViewLayout.collectionViewContentSize.height;
    if (!self.heightConstraint) {
        self.heightConstraint = [[self.view constrainHeight:@(height).stringValue] lastObject];
    } else {
        self.heightConstraint.constant = height;
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self setItemSizeForSize:size];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self updateHeightConstraint];
    } completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setItemSizeForSize:self.view.frame.size];
    [self updateHeightConstraint];
}

- (void) loadView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat sideMargin = [UIDevice isPad] ?  50 : 20;
    layout.sectionInset = UIEdgeInsetsMake(20, sideMargin, 20, sideMargin);
    layout.minimumInteritemSpacing = sideMargin;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];

    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[ARFavoriteItemViewCell class] forCellWithReuseIdentifier:@"RelatedArtistCell"];

    self.view = collectionView;
}

- (void)setItemSizeForSize:(CGSize)size
{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.view.collectionViewLayout;
    layout.itemSize = [ARFavoriteItemViewCell sizeForCellwithSize:size layout:layout];
    [self.view.collectionViewLayout invalidateLayout];
    [self.view layoutIfNeeded];
}

#pragma mark -
#pragma mark Related artist delegate/datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.relatedArtists.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    ARFavoriteItemViewCell *cell = (ARFavoriteItemViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"RelatedArtistCell" forIndexPath:indexPath];

    Artist *artist = self.relatedArtists[indexPath.row];
    [cell setupWithRepresentedObject:artist];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Artist *artist = self.relatedArtists[indexPath.row];
    UIViewController *viewController = [[ARSwitchBoard sharedInstance] loadArtistWithID:artist.artistID inFair:self.fair];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (CGSize)preferredContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, self.view.collectionViewLayout.collectionViewContentSize.height);
}

@end
