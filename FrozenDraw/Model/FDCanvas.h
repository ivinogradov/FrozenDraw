//
//  FDCanvas.h
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/7/16.
//
//

#import "FDDrawingPath.h"

/*! 
 *	@discussion This class if the model for our drawing. It contains all the necessary information
 *			for the drawing to be rendered.
 */
@interface FDCanvas : NSObject

/*! @brief An array of so called strokes, which are UIColor and UIBezierPath packaged together */
@property (nonatomic) NSMutableArray<FDDrawingPath *> * strokes;

@end
