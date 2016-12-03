//
//  FDCanvas.h
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/7/16.
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

#import "FDDrawingPath.h"

/*! 
 *	@discussion This class if the model for our drawing. It contains all the necessary information
 *			for the drawing to be rendered.
 */
@interface FDCanvas : NSObject

/*! @brief An array of so called strokes, which are UIColor and UIBezierPath packaged together */
@property (nonatomic) NSMutableArray<FDDrawingPath *> * strokes;

@end
