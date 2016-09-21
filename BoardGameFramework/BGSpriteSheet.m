//
//  BGSpriteSheet.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2016-05-08.
//  Copyright © 2016 Benjamin Wishart. All rights reserved.
//

#import "BGSpriteSheet.h"



@implementation BGSpriteSheet

- (id)initWithImage:(UIImage *)image atSize:(CGSize)size {
    if (self = [super initWithCGImage:image.CGImage]) {
        spriteSize = size;
    }
    
    return self;
}

- (UIImage *)imageAtPoint:(CGPoint)point {
    CGRect frame = CGRectMake(point.x, point.y, spriteSize.width, spriteSize.height);
    
    return [self imageAtFrame:frame];
}

- (UIImage *)imageAtFrame:(CGRect)frame {
    CGImageRef sprite = CGImageCreateWithImageInRect(self.CGImage, frame);
    return [UIImage imageWithCGImage:sprite];
}


@end
