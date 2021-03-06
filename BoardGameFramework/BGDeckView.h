//
//  BGDeckView.h
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2016-01-31.
//  Copyright © 2016 Benjamin Wishart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGView.h"

@class CardView;
@class BGDeckView;

@protocol BGDeckViewDelegate <NSObject>

- (void)cardView:(CardView *)cardView wasDealtToPoint:(CGPoint)point;

@end

@interface BGDeckView : BGView

/**
 *  The point at which new cards are dealt from i.e. where cards animate from. This is initialized to be the center
 *  of the deckview.
 */
@property (nonatomic) CGPoint drawPointCenter;

@property (nonatomic, strong) id<BGDeckViewDelegate>  delegate;

/**
 *  Animates a cardView from drawPointCenter to the given dealPoint
 *
 *  @param dealPoint : the end point to which a cardView will animate
 */
- (void)dealToPoint:(CGPoint)dealPoint;

/**
 *  Animates a cardView from drawPointCenter to the given dealPoint
 *  First animates the card to face a particular point
 *
 *  @param dealPoint : the end point to which a cardView will animate
 */
- (void)dealToPoint:(CGPoint)dealPoint withSide:(Side)side facingPoint:(CGPoint)facingPoint;

/**
 *  Animates a cardView from a specified point to the given dealPoint
 *  First animates the card to face a particular point
 *
 *  @param dealPoint : the end point to which a cardView will animate
 */
- (void)dealToPoint:(CGPoint)dealPoint fromPoint:(CGPoint)fromPoint withSide:(Side)side facingPoint:(CGPoint)facingPoint;

@end
