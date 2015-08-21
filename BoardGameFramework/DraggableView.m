//
//  DraggableView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-02-28.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import "DraggableView.h"

@implementation DraggableView
@synthesize staysWithinSuperView;
@synthesize lockX, lockY;

-(id)initWithCoder:(NSCoder *)aDecoder
{
   if (self = [super initWithCoder:aDecoder])
   {
      self.userInteractionEnabled = YES;
      [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cardIsBeingDraggedWithPanGestureRecognizer:)]];
   }
   
   return self;
}

- (void)setWillDrag:(BOOL)willDrag {
   self.userInteractionEnabled = willDrag;
}

- (BOOL)willDrag {
   return self.userInteractionEnabled;
}

-(void)cardIsBeingDraggedWithPanGestureRecognizer: (UIPanGestureRecognizer *)sender
{
   if (sender.state == UIGestureRecognizerStateBegan)
   {
      [self.delegate view:self didStartDraggingWithGestureRecognizer:sender];
   }
   
   CGPoint translationPoint = [sender translationInView:self.superview];
   CGFloat x = lockX ? sender.view.center.x : sender.view.center.x + translationPoint.x;
   CGFloat y = lockY ? sender.view.center.y : sender.view.center.y + translationPoint.y;
   CGPoint newCenterPoint = CGPointMake(x, y);
   CGFloat halfViewWidth = self.frame.size.width / 2;
   CGFloat halfViewHeight = self.frame.size.height / 2;
   
   if ((staysWithinSuperView
        && CGRectContainsPoint(self.superview.frame, CGPointMake(newCenterPoint.x, newCenterPoint.y + halfViewHeight))
        && CGRectContainsPoint(self.superview.frame, CGPointMake(newCenterPoint.x, newCenterPoint.y - halfViewHeight))
        && CGRectContainsPoint(self.superview.frame, CGPointMake(newCenterPoint.x + halfViewWidth, newCenterPoint.y))
        && CGRectContainsPoint(self.superview.frame, CGPointMake(newCenterPoint.x - halfViewWidth, newCenterPoint.y))) || !staysWithinSuperView) {
      sender.view.center = newCenterPoint;
      [sender setTranslation:CGPointZero inView:self.superview];
   }
   
   [self.delegate view:self isDraggingWithGestureRecognizer:sender];

   if (sender.state == UIGestureRecognizerStateEnded)
   {
      [self.delegate view:self didEndDraggingWithGestureRecognizer:sender];
   }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
