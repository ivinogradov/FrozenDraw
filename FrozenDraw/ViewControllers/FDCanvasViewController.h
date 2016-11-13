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

@interface FDCanvasViewController : UIViewController<FDColorPickerDelegate>

@property (weak, nonatomic) IBOutlet FDCanvasView *canvasView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *colorButton;
@property (nonatomic) UIColor *selectedColor;
@end

// Auxiliary category
@interface UIImage (ViewConverter)
//TODO: documentation
+ (UIImage *) imageWithView:(UIView *) view;
@end
