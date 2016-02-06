//
//  BGDeckView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2016-01-31.
//  Copyright © 2016 Benjamin Wishart. All rights reserved.
//

#import "BGDeckView.h"
#import "CardView.h"

@interface BGDeckView () {
    UIImageView *cardDisplayImageView;
}

@end

@implementation BGDeckView
@synthesize drawPointCenter;
@synthesize delegate;

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
    cardDisplayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,
                                                                         0.0,
                                                                         self.frame.size.width,
                                                                         self.frame.size.height)];
    [self addSubview:cardDisplayImageView];
    [cardDisplayImageView setImage:[CardView cardBackImage]];
}

- (void)dealToPoint:(CGPoint)dealPoint {
    CardView *dealtCard = [[CardView alloc] initWithFrame:self.frame];
    [dealtCard showBack];
    
    dealtCard.center = drawPointCenter;
    
    [self.superview addSubview:dealtCard];
    
    [UIView animateWithDuration:0.2 animations:^{
        [dealtCard rotateSide:TOP toFacePoint:dealPoint];
    }];
    
    [UIView animateWithDuration:0.4 animations:^{
        [dealtCard rotateSide:TOP toFacePoint:dealPoint];
        dealtCard.center = dealPoint;
    } completion:^(BOOL finished) {
        [dealtCard removeFromSuperview];
        [delegate cardView:dealtCard wasDealtToPoint:dealPoint];
    }];
}

@end
