//
//  UIView+Rotation.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-12-28.
//  Copyright © 2015 Benjamin Wishart. All rights reserved.
//

#import "UIView+Rotation.h"

@implementation UIView (Rotation)

CGFloat ConvertDegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
}

CGFloat ConvertRadiansToDegrees(CGFloat radians) {
    return radians * 180 / M_PI;
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
