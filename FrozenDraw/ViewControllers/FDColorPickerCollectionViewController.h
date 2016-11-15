//
//  FDColorPickerCollectionViewController.h
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/10/16.
//
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@protocol FDColorPickerDelegate

/*! 
 *	@brief This is a delegate callback method which is called every time a user selects a new color from the color picker.
 *	@param pickedColor is a UIColor object for the color that was selected.
 */
-(void) newColorPicked:(UIColor *) pickedColor;
@end

@interface FDColorPickerCollectionViewController : UICollectionViewController

/*! @brief A weak reference to the delegate object on which the FDColorPickerDelegate protocol methods are being called. */
@property (nonatomic, weak) id<FDColorPickerDelegate> delegate;
@end

