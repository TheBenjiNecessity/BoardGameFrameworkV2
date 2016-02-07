//
//  CardView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-02-20.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import "CardView.h"
#import "UIView+Rotation.h"

@interface CardView () {
    UIImageView *cardDisplayImageView;
}

@end

@implementation CardView
@synthesize cardFrontImage;

- (void)initialize {
    [super initialize];
    cardDisplayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,
                                                                         0.0,
                                                                         self.frame.size.width,
                                                                         self.frame.size.height)];
    [self addSubview:cardDisplayImageView];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(cardIsTapped:)]];
}

+ (UIImage *)cardBackImage
{
    static UIImage *back;
    if (back == nil)
    {
        back = [UIImage imageNamed:@"cardBack"];
    }
    return back;
}

- (void)showBack {
    [cardDisplayImageView setImage:[CardView cardBackImage]];
}

- (void)showFront {
    [cardDisplayImageView setImage:cardFrontImage];
}

- (void)cardIsTapped:(UITapGestureRecognizer*)sender {

}

- (void)resetRotation {
#warning this won't mix with other transforms
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

- (void)rotateSide:(Side)side toFacePoint:(CGPoint)point {
    CGFloat sideAngleAddition;
    
    switch (side) {
        case TOP:
            sideAngleAddition = 0;
            break;
        case BOTTOM:
            sideAngleAddition = 180;
            break;
        case LEFT:
            sideAngleAddition = 90;
            break;
        case RIGHT:
            sideAngleAddition = -90;
        default:
            break;
    }
    
    CGFloat angle = atan2(point.y - self.center.y, point.x - self.center.x );
    angle = ConvertRadiansToDegrees(angle);
    
    if (angle < 0)
    {
        angle = 360 + angle;
    }
    
    angle = ConvertDegreesToRadians(90 + sideAngleAddition + angle);
    [self setTransform:CGAffineTransformMakeRotation(angle)];
}

@end
