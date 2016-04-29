//
//  BGView.h
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2016-02-07.
//  Copyright © 2016 Benjamin Wishart. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum side
{
    TOP, RIGHT, BOTTOM, LEFT
} Side;

@interface BGView : UIView

- (void)initialize;

@end
