//
//  FDCanvasView.h
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
