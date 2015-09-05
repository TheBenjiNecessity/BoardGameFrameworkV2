//
//  QuadTreeView.h
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-07-01.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#define NUMBER_OF_SLOTS_WIDE        10
#define NUMBER_OF_SLOTS_HIGH        7

#import <UIKit/UIKit.h>

#import "QuadTree.h"

@interface SlotViewCollectionView : UIView

@property (nonatomic) NSMutableArray *rows;

@property (nonatomic) QuadTree *quadTree;
@property (nonatomic) SlotView *selectedSlotview;

- (void)insertIntoQuadTreeSlotView:(SlotView *)slotView;
- (void)highlightSlotviewAtPoint: (CGPoint)point;

@end
