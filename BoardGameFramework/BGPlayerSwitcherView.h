//
//  BGPlayerSwitcherView.h
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2016-02-09.
//  Copyright © 2016 Benjamin Wishart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGView.h"

typedef enum bGPlayerSwitcherViewSwitchType
{
    SWEEPLEFT, SWEEPRIGHT, SWEEPUP, SWEEPDOWN, PEEKTOP, PEEKBOTTOM, PEEKLEFT, PEEKRIGHT, CUSTOM
} BGPlayerSwitcherViewSwitchType;

@interface BGPlayerSwitcherView : BGView

@property (nonatomic) BOOL waitsForManualDismissal;
@property (nonatomic) NSTimeInterval timeToAutoDismiss;
@property (nonatomic) BGPlayerSwitcherViewSwitchType switchType;

@end
