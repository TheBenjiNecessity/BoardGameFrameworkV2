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

@end
