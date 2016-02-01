//
//  CardView.h
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-02-20.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DraggableView.h"

@interface CardView : DraggableView

@property (nonatomic) UIImage *cardFrontImage;

+ (UIImage *)cardBackImage;
- (void)showBack;
- (void)showFront;

@end
