//
//  QuadTreeView.h
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-07-01.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#define NUMBER_OF_SLOTS_WIDE        10
#define NUMBER_OF_SLOTS_HIGH        7

#define MAX_BOX_HEIGHT              60
#define MAX_BOX_WIDTH               80

#define MIN_BOX_HEIGHT              30
#define MIN_BOX_WIDTH               40

#import <UIKit/UIKit.h>

#import "QuadTree.h"

@interface SlotViewCollectionView : UIView
{
    CGSize boxSize;
}

@property (nonatomic) NSMutableArray *rows;

@property (nonatomic) QuadTree *quadTree;
@property (nonatomic) SlotView *selectedSlotview;

- (void)insertIntoQuadTreeSlotView:(SlotView *)slotView;
- (void)highlightSlotviewAtPoint: (CGPoint)point;

@end
