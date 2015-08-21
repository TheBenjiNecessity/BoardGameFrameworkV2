//
//  QuadTreeView.h
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-07-01.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QuadTree.h"

@interface SlotViewCollectionView : UIView

@property (nonatomic) QuadTree *quadTree;
@property (nonatomic) SlotView *selectedSlotview;

- (void)insertIntoQuadTreeSlotView:(SlotView *)slotView;
- (void)highlightSlotviewAtPoint: (CGPoint)point;

@end
