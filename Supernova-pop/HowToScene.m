//
//  HowToScene.m
//  Supernova-pop
//
//  Created by Jason Rikard on 8/24/13.
//  Copyright 2013 Jason Rikard. All rights reserved.
//

#import "HowToScene.h"


@implementation HowToScene
+(CCScene *) scene{
    CCScene *scene=[CCScene node];
    
    HowToScene *layer = [HowToScene node];
    
    [scene addChild: layer];
    
    return scene;
}

-(id)init{
    if( (self=[super init] )) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"How to Play"
                                               fontName:@"Courier New"
                                               fontSize:90];
        label.position = ccp(winSize.width/2, winSize.height/1.15);
        
        [self addChild: label];
        
        CCLabelTTF *instructions = [CCLabelTTF labelWithString:@"Prevent damage to the universe by controlling the expansion\n of the stars.  Stars too big or too small will hurt the galaxy.\n  Make the growing stars stay in a stable state by\n tapping them while they are within a nominal threshold.  "
                                               fontName:@"Courier New"
                                               fontSize:26];
        instructions.position = ccp(winSize.width/2, winSize.height/1.35);
        
        [self addChild: instructions];
        
        [CCMenuItemFont setFontName:@"Courier New"];
        [CCMenuItemFont setFontSize:70];
        
        CCMenuItem *Resume= [CCMenuItemFont itemWithString:@"Got it!"
                                                    target:self
                                                  selector:@selector(resume:)];
        
        CCMenu *menu= [CCMenu menuWithItems: Resume, nil];
        menu.position = ccp(winSize.width/2, winSize.height/4.2);
        [menu alignItemsVerticallyWithPadding:12.5f];
        
        [self addChild:menu];
        
    }
    return self;
}

-(void) resume: (id) sender {
    
    [[CCDirector sharedDirector] popScene];
}

@end
