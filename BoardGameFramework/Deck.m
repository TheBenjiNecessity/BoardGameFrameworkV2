//
//  Deck.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-02-20.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import "Deck.h"

@implementation Deck

/* Init methods */
-(id)initWithJSONFile: (NSData *)JSONFile
{
    if (self = [super init]) {
        NSError *error = nil;
        id JSON = [NSJSONSerialization JSONObjectWithData:JSONFile
                                                  options:0
                                                    error:&error];
        
        if (error) {
            @throw [NSException exceptionWithName:NSGenericException
                                           reason:@"The JSON in the file provided is either malformed or the file could not be opened."
                                         userInfo:nil];
        } else {
            if ([JSON isKindOfClass:[NSDictionary class]]) {
                cardInfoFromJSONFile = [JSON objectForKey:@"cards"];
                
                for (NSDictionary *cardDictionary in cardInfoFromJSONFile) {
                    Card *card = [[Card alloc] initWithDictionary:cardDictionary];
                }
            } else {
                @throw [NSException exceptionWithName:NSGenericException
                                               reason:@"Could not parse JSON from file provided."
                                             userInfo:nil];
            }
        }
    }
    
    /* Any subclasses of BGDeck should have */
    return self;
}

- (void)print {
    for (id card in cardInfoFromJSONFile) {
        NSLog(@"card");
        for (id key in card) {
            NSLog(@"%@, %@", key, [card objectForKey:key]);
        }
    }
}

/* Accessor methods */
-(Card *)draw
{
    if (![self isEmpty])
    {
        Card *drawnCard = [cards objectAtIndex:0];
        [cards removeObjectAtIndex:0];
        return drawnCard;
    }
    else
        return nil;
}

-(BOOL)addCard:(Card *)card {
    if (card != nil) {
        [cards addObject:card];
        return YES;
    } else {
        return NO;
    }
}

/* Helper Methods */

-(BOOL)isEmpty
{
    return cards.count <= 0;
}

-(void)shuffle
{
    for (int i = 0; i < cards.count; i++) {
        [cards exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((u_int32_t)cards.count)];
    }
}

@end
