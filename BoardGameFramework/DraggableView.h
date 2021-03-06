//
//  DraggableView.h
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-02-28.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGView.h"

@class DraggableView;
@protocol DraggableViewDelegate <NSObject>

- (void)view: (UIView *)view didStartDraggingWithGestureRecognizer: (UIPanGestureRecognizer *)recognizer;

- (void)view: (UIView *)view didEndDraggingWithGestureRecognizer: (UIPanGestureRecognizer *)recognizer;

- (void)view: (UIView *)view isDraggingWithGestureRecognizer:(UIPanGestureRecognizer *)recognizer;

@end

@interface DraggableView : BGView <UIGestureRecognizerDelegate>

@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

@property (nonatomic) BOOL willDrag;
@property (nonatomic) BOOL lockX;
@property (nonatomic) BOOL lockY;
@property (nonatomic) BOOL staysWithinSuperView;
@property (nonatomic) BOOL createsDraggableCopy;
@property (nonatomic) BOOL expandsOnTouch;
@property (nonatomic) BOOL isHighlighted;

@property (nonatomic, strong) id<DraggableViewDelegate>  delegate;

@end
