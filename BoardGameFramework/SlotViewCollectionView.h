//
//  QuadTreeView.h
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-07-01.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#define BOX_DIM              30

#import <UIKit/UIKit.h>
#import "SlotView.h"

@interface SlotViewCollectionView : UIView

@property (nonatomic, readonly) int numberOfSlotsHigh;
@property (nonatomic, readonly) int numberOfSlotsWide;

@property (nonatomic) NSMutableArray *rows;

- (void)insertSlotView:(SlotView *)slotView;
- (SlotView *)slotViewAtPoint:(CGPoint)point;

@end
