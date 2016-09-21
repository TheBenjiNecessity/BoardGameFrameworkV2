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
    [self dealToPoint:dealPoint withSide:TOP facingPoint:dealPoint];
}

- (void)dealToPoint:(CGPoint)dealPoint fromPoint:(CGPoint)fromPoint {
    
    [self dealToPoint:dealPoint fromPoint:fromPoint withSide:TOP facingPoint:dealPoint];
}

- (void)dealToPoint:(CGPoint)dealPoint withSide:(Side)side facingPoint:(CGPoint)facingPoint {
    [self dealToPoint:dealPoint fromPoint:self.frame.origin withSide:side facingPoint:facingPoint];
}

- (void)dealToPoint:(CGPoint)dealPoint fromPoint:(CGPoint)fromPoint withSide:(Side)side facingPoint:(CGPoint)facingPoint {
    CardView *dealtCard = [[CardView alloc] init];
    [dealtCard setFrame:CGRectMake(fromPoint.x, fromPoint.y, self.frame.size.width, self.frame.size.height)];
    [dealtCard showBack];
    
    dealtCard.center = drawPointCenter;
    
    [self.superview addSubview:dealtCard];
    
    [UIView animateWithDuration:0.2 animations:^{
        [dealtCard rotateSide:side toFacePoint:facingPoint];
    }];
    
    [UIView animateWithDuration:0.4 animations:^{
        [dealtCard rotateSide:side toFacePoint:facingPoint];
        dealtCard.center = dealPoint;
    } completion:^(BOOL finished) {
        [dealtCard removeFromSuperview];
        [delegate cardView:dealtCard wasDealtToPoint:dealPoint];
    }];
}

@end
