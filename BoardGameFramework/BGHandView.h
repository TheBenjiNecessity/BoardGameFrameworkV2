//
//  BGHandView.h
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-10-09.
//  Copyright © 2015 Benjamin Wishart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

@protocol BGHandView <NSObject>

@property (nonatomic) NSMutableArray *cardViews;
@property (nonatomic) CGSize cardSize;

- (id)initWithFrame:(CGRect)frame;

- (void)addCardView:(CardView *)cardView;

- (void)removeCardViewAtIndex:(int)index;

- (void)removeCardView:(CardView *)cardView;

- (void)refreshHand;

@end
