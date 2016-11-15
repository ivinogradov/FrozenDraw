//
//  FDCanvasViewController.h
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/5/16.
//
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "FDCanvasView.h"
#import "FDColorPickerCollectionViewController.h"
#import "UIImage+ViewConverter.h"

@interface FDCanvasViewController : UIViewController<FDColorPickerDelegate>

/*! @brief Canvas view is a UIView object containing managing all the layers with individual strokes. */
@property (weak, nonatomic) IBOutlet FDCanvasView *canvasView;

/*! @brief A button displaying the current color as well as launching the color picker. */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *colorButton;

/*! @brief Current color we are drawing with. */
@property (nonatomic) UIColor *selectedColor;
@end
