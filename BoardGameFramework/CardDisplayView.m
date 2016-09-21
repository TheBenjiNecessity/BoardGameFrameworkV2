//
//  CardDisplayView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2016-02-20.
//  Copyright © 2016 Benjamin Wishart. All rights reserved.
//

#import "CardDisplayView.h"

@interface CardDisplayView () {
    UIImageView *cardDisplayImageView;
}

@end

@implementation CardDisplayView

- (void)initialize {
    [super initialize];
    cardDisplayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,
                                                                         0.0,
                                                                         self.frame.size.width,
                                                                         self.frame.size.height)];
    [self addSubview:cardDisplayImageView];
}



@end
