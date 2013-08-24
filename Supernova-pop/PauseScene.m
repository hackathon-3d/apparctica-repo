//
//  PauseScene.m
//  Supernova-pop
//
//  Created by Jason Rikard on 8/24/13.
//  Copyright 2013 Jason Rikard. All rights reserved.
//

#import "PauseScene.h"
#import "HelloWorldLayer.h"
#import "StartMenu.h"

@implementation PauseScene
+(CCScene *) scene{
    CCScene *scene=[CCScene node];
    
    PauseScene *layer = [PauseScene node];
    
    [scene addChild: layer];
    
    return scene;
}

-(id)init{
    if( (self=[super init] )) {
        CGSize winSize = [CCDirector sharedDirector].winSize;

        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Paused"
                                               fontName:@"Courier New"
                                               fontSize:30];
        label.position = ccp(240,190);
        [self addChild: label];
        [CCMenuItemFont setFontName:@"Courier New"];
        [CCMenuItemFont setFontSize:60];
        
        CCMenuItem *Resume= [CCMenuItemFont itemWithString:@"Resume"
                                                    target:self
                                                  selector:@selector(resume:)];
        CCMenuItem *Quit = [CCMenuItemFont itemWithString:@"Quit Game"
                                                   target:self selector:@selector(GoToMainMenu:)];
        
        CCMenu *menu= [CCMenu menuWithItems: Resume, Quit, nil];
        menu.position = ccp(winSize.width/2, winSize.height/2);
        [menu alignItemsVerticallyWithPadding:12.5f];
        
        [self addChild:menu];
        
    }
    return self;
}

-(void) resume: (id) sender {
    
    [[CCDirector sharedDirector] popScene];
}

-(void) GoToMainMenu: (id) sender {
    
    [[CCDirector sharedDirector] sendCleanupToScene];
    [[CCDirector sharedDirector] popScene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1
                                               scene:[StartMenu node]]
     ];
}
@end
