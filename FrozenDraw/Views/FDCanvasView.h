//
//  FDCanvasView.h
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/5/16.
//
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "FDCanvas.h"

@interface FDCanvasView : UIView

/*! @brief Starting coordinate of the curve being drawn. */
//@property (nonatomic) CGPoint startingPoint;
//@property (nonatomic) UIBezierPath *drawPath;
//@property (nonatomic) UIColor *currentColor;


/*!
 @brief Draws a line from the previos point to the given point.
		If there was no previos point - starting point is used.
 */
//- (void)drawLineToPoint:(CGPoint) point;

/*! 
 @brief Clears the drawing in canvas
 */
//- (void)clearCanvas;

//- (void)reflectCanvas:(FDCanvas *)canvas;

@end
