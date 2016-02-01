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
    cardDisplayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,
                                                                         0.0,
                                                                         self.frame.size.width,
                                                                         self.frame.size.height)];
    [self addSubview:cardDisplayImageView];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(cardIsTapped:)]];
}

+(UIImage *)cardBackImage
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

@end
