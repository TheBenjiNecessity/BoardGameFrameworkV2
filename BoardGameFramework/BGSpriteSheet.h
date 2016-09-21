//
//  BGSpriteSheet.h
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2016-05-08.
//  Copyright © 2016 Benjamin Wishart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGSpriteSheet : UIImage
{
    CGSize spriteSize;
}

- (id)initWithImage:(UIImage *)image atSize:(CGSize)size;

- (UIImage *)imageAtPoint:(CGPoint)point;

@end
