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

@interface FDCanvasViewController : UIViewController

@property (weak, nonatomic) IBOutlet FDCanvasView *canvasView;
@end
