//
//  BGDeckView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2016-01-31.
//  Copyright © 2016 Benjamin Wishart. All rights reserved.
//

#import "BGDeckView.h"
#import "CardView.h"

@implementation BGDeckView
@synthesize drawPointCenter;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [self setDrawPointCenter:self.center];
}

- (void)dealToPoint:(CGPoint)dealPoint {
    CardView *dealtCard = [[CardView alloc] initWithFrame:self.frame];
    [dealtCard setCardFrontImage:[CardView cardBackImage]];
    dealtCard.center = drawPointCenter;
    
    [UIView animateWithDuration:0.5 animations:^{
        dealtCard.center = dealPoint;
    } completion:^(BOOL finished) {
        
    }];
}

@end
