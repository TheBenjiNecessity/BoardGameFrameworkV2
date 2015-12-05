//
//  BGScrollingHandView.h
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-10-13.
//  Copyright © 2015 Benjamin Wishart. All rights reserved.
//

#import <BoardGameFramework/BoardGameFramework.h>

#import "BGHandView.h"

@interface BGScrollingHandView : UIScrollView <BGHandView, UIGestureRecognizerDelegate>

@property (nonatomic) CGFloat cardMargin;

@property (nonatomic) SlotViewCollectionView *collectionView;

- (void)initialize;

@end
