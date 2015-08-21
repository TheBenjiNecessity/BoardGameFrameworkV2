//
//  SlotView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-02-20.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import "SlotView.h"
#import "QuadTreeView.h"


@implementation SlotView

- (id)initWithFrame:(CGRect)frame {
   if (self = [super initWithFrame:frame]) {

   }
   return self;
}

- (void)didMoveToSuperview {
   if ([self.superview isKindOfClass:[QuadTreeView class]]) {
      [(QuadTreeView *)self.superview insertIntoQuadTreeSlotView:self];
   } else {
      [NSException raise:@"Invalid SlotView Placement"
                  format:@"%@s can only be placed inside of %@.",
       NSStringFromClass([SlotView class]),
       NSStringFromClass([QuadTreeView class])];
   }
}

- (void)slotViewIsHighlighted:(BOOL)highlighted {
   if (highlighted) {
      self.layer.borderColor = [UIColor blackColor].CGColor;
      self.layer.borderWidth = 1.0;
   } else {
      self.layer.borderColor = [UIColor clearColor].CGColor;
      self.layer.borderWidth = 0.0;
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
