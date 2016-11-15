//
//  UIImage+ViewConverter.h
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/14/16.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (ViewConverter)

/*!
 *	@brief Creates a UIImage object from a UIView object.
 *	@description Uses Core Graphics to create a render the passed in view to an image.
 *	@param view is a UIView object we are creating a UIImage from.
 *	@return	UIImage object created with the provided UIView object.
 */
+ (UIImage *) imageWithView:(UIView *) view;

@end
