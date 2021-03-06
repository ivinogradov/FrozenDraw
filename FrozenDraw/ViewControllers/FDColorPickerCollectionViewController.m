//
//  FDColorPickerCollectionViewController.m
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/10/16.
//
//  This file is part of FrozenDraw(c).  FrozenDraw(c) is licenced under the MIT License.
//  See http://opensource.org/licenses/MIT for detailed information.
//
//	The reference to FrozenDraw(c) is appreciated but not required in your own product.
//	While the source code is licensed under the MIT License, that license doesn't cover the product's name.
//	You may not release your product under names "FrozenDraw" or "Frozen Draw".
//
//  Copyright (c) 2016 Ilya Vinogradov. All rights reserved.
//

#import "FDColorPickerCollectionViewController.h"

@interface FDColorPickerCollectionViewController ()

@end

@implementation FDColorPickerCollectionViewController

// The color model for the picker
static NSArray<UIColor *> * kColors;
static NSString * const reuseIdentifier = @"colorCell";	// not using "k" prefix because that's how the storyboard expects it
static const int kNumberOfColors  = 15;					//use all 14 iOS defined colors + teal
static const CGFloat kCellPadding = 10.0;

#pragma mark - VC Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIColor * tealColor = [UIColor colorWithRed:0.0 green:0.5 blue:0.5 alpha:1]; //make 1 more color to make it 15 so they fit nicely on the screen
	
	// Setup all standard iOS colors
	kColors = @[[UIColor blackColor], [UIColor darkGrayColor], [UIColor grayColor], [UIColor lightGrayColor], [UIColor whiteColor],			//monocrome
				[UIColor brownColor], [UIColor redColor] , [UIColor orangeColor], [UIColor yellowColor],									//red spectrum
				[UIColor greenColor], tealColor, [UIColor cyanColor], [UIColor blueColor] , [UIColor magentaColor], [UIColor purpleColor]];	//blue spectrum
}


// Reload the collection view (and resize the cells) on rotations and other layout changes
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
	[coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
		[self.collectionView performBatchUpdates:nil completion:nil];
	}];
	
	[super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kNumberOfColors;
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


#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([_delegate respondsToSelector:@selector(colorPicker:didPickColor:)]) {
		[_delegate colorPicker:self didPickColor:kColors[indexPath.row]];
	}
	
}

#pragma mark - Auxiliary methods


/*!
 *	@brief Calculates the optimal size for a cell given supplied screen dimensions.
 *	@discussion This method would return a CGSize (to size the UICollectionView cell) based on visible screen dimensions
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

@end
