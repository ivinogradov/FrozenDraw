//
//  FDCanvasView.h
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/5/16.
//
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "FDDrawingPath.h"

@interface FDCanvasView : UIView

/*! @brief Prepares the canvas view to draw a new stroke. */
-(void)beginNewStroke;

/*!
 *	@brief Updates the currently drawn stroke to follow the drawing path.
 *	@param drawingPath a path with color to be drawn.
 */
-(void)updateStrokeWithDrawingPath:(FDDrawingPath *) drawingPath;

/*! @brief Removes the current stroke in progress from the canvas. */
-(void)removeCurrentStroke;

/*!
 *	@discussion Removes the current stroke in progress from the canvas.
 *			If there is no current stroke in progress available, removes the most recent completed stroke.
 */
-(void)removeLastStroke;

/*! @brief Clears the drawing in canvas */
-(void)clearCanvas;

@end
