//
//  FDColorPickerCollectionViewController.h
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

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@class FDColorPickerCollectionViewController;

@protocol FDColorPickerDelegate <NSObject>

/*! 
 *	@brief This is a delegate callback method which is called every time a user selects a new color from the color picker.
 *	@param picker is an instance of FDColorPickerCollectionViewController calling this method on its delegate
 *	@param pickedColor is a UIColor object for the color that was selected.
 */
-(void) colorPicker:(FDColorPickerCollectionViewController *)picker didPickColor:(UIColor *) pickedColor;
@end

@interface FDColorPickerCollectionViewController : UICollectionViewController

/*! @brief A weak reference to the delegate object on which the FDColorPickerDelegate protocol methods are being called. */
@property (nonatomic, weak) id<FDColorPickerDelegate> delegate;
@end

