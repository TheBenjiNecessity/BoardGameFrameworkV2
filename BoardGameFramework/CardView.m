//
//  CardView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-02-20.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import "CardView.h"
#import "UIView+Rotation.h"

@implementation CardView

//the way cardview should work is it should create a draggable copy of itself rather than allow itself to be dragged.
//This will work when pulling the view out of a subview.

+(UIImage *)cardBackImage
{
    static UIImage *back;
    if (back == nil)
    {
        
    }
    return back;
}

- (void)resetRotation {
    self.transform = CGAffineTransformIdentity;
}

- (void)rotateAroundBottomCenterByDegrees:(CGFloat)degrees {
    CGFloat radians = ConvertDegreesToRadians(degrees);
    [self rotateAroundBottomCenterByRadians:radians];
}

- (void)rotateAroundBottomCenterByRadians:(CGFloat)radians {
    [[self layer] setAnchorPoint:CGPointMake(0.5, 1.0)];
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0.0, self.frame.size.height / 2);
    transform = CGAffineTransformRotate(transform, radians);
    
    self.transform = transform;
}

@end
