//
//  FDColorPickerCollectionViewController.m
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/10/16.
//
//

#import "FDColorPickerCollectionViewController.h"

@interface FDColorPickerCollectionViewController ()

@end

@implementation FDColorPickerCollectionViewController

static NSArray<UIColor *> * kColors;
static NSString * const reuseIdentifier = @"colorCell";
static const int kNumberOfColors  = 15;
static const CGFloat kCellPadding = 10.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
	
	UIColor * tealColor = [UIColor colorWithRed:0.0 green:0.5 blue:0.5 alpha:1]; //make 1 more color to make it 15 so they fit nicely on the screen
	
	// Setup all standard iOS colors
	kColors = @[[UIColor blackColor], [UIColor darkGrayColor], [UIColor grayColor], [UIColor lightGrayColor], [UIColor whiteColor],		//monocrome
				[UIColor brownColor], [UIColor redColor] , [UIColor orangeColor], [UIColor yellowColor],								//red spectrum
				[UIColor greenColor], tealColor, [UIColor cyanColor], [UIColor blueColor] , [UIColor magentaColor], [UIColor purpleColor]];		//blue spectrum
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self.collectionView performBatchUpdates:nil completion:nil];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kNumberOfColors;	//use all 14 iOS defined colors
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Set cell color
	cell.backgroundColor = kColors[indexPath.row];
	
	// Make rounded corners
	cell.layer.cornerRadius = 0.3 * cell.bounds.size.height;
	
	// Make shadow
	cell.layer.masksToBounds = NO;
	cell.layer.shadowOpacity = 0.3;
	cell.layer.shadowRadius = 3.0;
	cell.layer.shadowOffset = CGSizeZero;
	cell.layer.shadowColor = [UIColor blackColor].CGColor;

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
				  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	CGFloat heighestDimension, lowestDimension;
	
	
	if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
		// fit numberOfColorsPerHeighestDimension cells plus padding across the width
		heighestDimension = self.collectionView.bounds.size.width;
		lowestDimension = self.collectionView.bounds.size.height - self.collectionView.contentInset.top; //account for navigation header
	} else {
		// fit numberOfColorsPerHeighestDimension cells plus padding across the height
		heighestDimension = self.collectionView.bounds.size.height - self.collectionView.contentInset.top; //account for navigation header
		lowestDimension = self.collectionView.bounds.size.width;
	}
	
	return [self _sizeOfCellForHeighestDimentions:heighestDimension andLowestDimension:lowestDimension];
}

/*!
 *	@brief Calculates the optimal size for a cell given supplied screen dimensions.
 *	@description This method would return a CGSize (to size the UICollectionView cell) based on visible screen dimensions
 *		such that all cells of this size will fit on the screen and won't be cut off. It assumes 3 cells per lowest dimension
 *		and takes into account the total number of cells (kNumberOfColors) and the space between cells (kCellPadding).
 *	@param heighestDimension Size of the long side of the visible part of the view frame
 *	@param lowestDimension Size of the short side of the visible part of the view frame
 *	@return CGSize of the cell such that all of them fit in the view with dimensions specified
 */
-(CGSize) _sizeOfCellForHeighestDimentions:(CGFloat)heighestDimension andLowestDimension:(CGFloat)lowestDimension {
	
	int numberOfColorsPerLowestDimension = 3;	//we want to have 3 rows of colors in landscape and 3 columns in portrait
	int numberOfColorsPerHeighestDimension = ceil(kNumberOfColors / (float)numberOfColorsPerLowestDimension);
	
	//leave padding on top and bottom, and account for spacing between cells
	CGFloat availableSpaceInHeighestDimension = heighestDimension - (numberOfColorsPerHeighestDimension + 1) * kCellPadding;
	CGFloat availableSpaceInLowestDimension = lowestDimension - (numberOfColorsPerLowestDimension + 1) * kCellPadding;
	
	//make sure all cells fit vertically and horizontally
	CGFloat cellDimension = MIN(availableSpaceInHeighestDimension / numberOfColorsPerHeighestDimension, availableSpaceInLowestDimension / numberOfColorsPerLowestDimension);
	return CGSizeMake(cellDimension, cellDimension);
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	[_delegate newColorPicked:kColors[indexPath.row]];
	[self.navigationController popViewControllerAnimated:YES];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
