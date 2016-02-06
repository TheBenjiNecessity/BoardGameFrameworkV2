//
//  UIView+Distance.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2016-02-05.
//  Copyright © 2016 Benjamin Wishart. All rights reserved.
//

#import "UIView+Distance.h"

@implementation UIView (Distance)

- (CGFloat)distanceFromPoint:(CGPoint)from toPoint:(CGPoint)to {
    return sqrtf(pow(from.x - to.x, 2) + pow(from.y - to.y, 2));
}

@end
