//
//  FDCanvasViewController.h
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/5/16.
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
#import "FDCanvasView.h"
#import "FDColorPickerCollectionViewController.h"
#import "UIImage+ViewConverter.h"

@interface FDCanvasViewController : UIViewController

/*! @brief Canvas view is a UIView object containing managing all the layers with individual strokes. */
@property (weak, nonatomic) IBOutlet FDCanvasView *canvasView;

/*! @brief A button displaying the current color as well as launching the color picker. */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *colorButton;

/*! @brief Current color we are drawing with. */
@property (nonatomic) UIColor *selectedColor;
@end
