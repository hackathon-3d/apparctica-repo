//
//  StartMenu.m
//  Supernova-pop
//
//  Created by Jason Rikard on 8/24/13.
//  Copyright 2013 Jason Rikard. All rights reserved.
//

#import "StartMenu.h"
#import "CircleClass.h"

@implementation StartMenu

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	StartMenu *layer = [StartMenu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
        
		CCMenu * myMenu = [CCMenu menuWithItems:nil];
        CCMenuItemImage *menuItem1 = [CCMenuItemImage itemWithNormalImage:@"start_button.png"
                                                            selectedImage: @"start_button.png"
                                                                   target:self
                                                                 selector:@selector(doSomething:)];
        [myMenu addChild:menuItem1];
        [self addChild:myMenu];
	}
	
	return self;
}

-(void)doSomething: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:3.0 scene:[CircleClass scene] ]];
}

@end
