//
//  UIImage+ViewConverter.m
//  FrozenDraw
//
//  Created by Ilya Vinogradov on 11/14/16.
//
//

#import "UIImage+ViewConverter.h"

@implementation UIImage (ViewConverter)

+ (UIImage *)imageWithView:(UIView *) view {
	UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
	[view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

@end
