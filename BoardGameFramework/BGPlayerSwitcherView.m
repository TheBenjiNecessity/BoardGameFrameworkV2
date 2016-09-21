//
//  BGPlayerSwitcherView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2016-02-09.
//  Copyright © 2016 Benjamin Wishart. All rights reserved.
//
//  A view that signals the passing off of play to another player

#import "BGPlayerSwitcherView.h"

@implementation BGPlayerSwitcherView
@synthesize waitsForManualDismissal;
@synthesize timeToAutoDismiss;

- (void)setSwitchType:(BGPlayerSwitcherViewSwitchType)switchType {
    _switchType = switchType;
    
    switch (_switchType) {
        case SWEEPDOWN:
        case SWEEPLEFT:
        case SWEEPRIGHT:
        case SWEEPUP:
            
            break;
        case PEEKBOTTOM:
        case PEEKLEFT:
        case PEEKRIGHT:
        case PEEKTOP:
            
            break;
        default:
            break;
    }
}


//custom would work by getting a animation block from the user to use to animate the view in?



@end
