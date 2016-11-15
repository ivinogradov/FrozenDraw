//
//  FDDrawingPath.h
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/7/16.
//
//

#import <UIKit/UIKit.h>

/*!
 *	@discussion This class roughly represents a stroke of paint:
 *					It encapsulates UIBezierPath and its color.
 *					The reason is not called "FDStroke" is because it actually inherits from
 *					UIBezierPath for easier access and for keeping track of the last touched point.
 */
@interface FDDrawingPath : UIBezierPath

/*! @brief A location of the last point of the stroke so far. Needed for computing the end point from transaltion. */
@property (nonatomic, readonly) CGPoint lastTouchedPoint;

/*! @brief Stroke color. */
@property (nonatomic, readonly) UIColor * pathColor;

/*! @brief Overriding UIBezierPath's method so we can keep track of the last point touched. */
-(void) drawLineToPoint:(CGPoint) point;

/*! 
 *	@brief Instantiates the stroke with the specified color and width of 2.0 points. Instantiates parent Bezier Path.
 *	@param	color is the color of the stroke
 */
-(instancetype) initWithColor:(UIColor *) color;

/*! 
 *	@brief Instantiates the stroke with the specified color and width. Instantiates parent Bezier Path.
 *	@param	color is the color of the stroke
 *	@param	width is the stroke width
 */
-(instancetype) initWithColor:(UIColor *)color andWidth:(CGFloat) width;

@end
