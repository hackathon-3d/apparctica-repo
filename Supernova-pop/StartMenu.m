//
//  StartMenu.m
//  Supernova-pop
//
//  Created by Jason Rikard on 8/24/13.
//  Copyright 2013 Jason Rikard. All rights reserved.
//

#import "StartMenu.h"
#import "HelloWorldLayer.h"

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
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        // Add stars
        NSArray *starsArray = [NSArray arrayWithObjects:@"Stars1.plist", @"Stars2.plist", @"Stars3.plist", nil];
        for(NSString *stars in starsArray) {
            CCParticleSystemQuad *starsEffect = [CCParticleSystemQuad particleWithFile:stars];
            starsEffect.position = ccp(winSize.width, winSize.height);
            starsEffect.posVar = ccp(starsEffect.posVar.x, winSize.height);
            starsEffect.startSize *= 0.5;
            starsEffect.endSize *= 1;
            starsEffect.speed *= 0.5;
            [self addChild:starsEffect z:1];
        }
        
        CCParticleSystemQuad *supasupa = [CCParticleSystemQuad particleWithFile:@"supasupa.plist"];
        supasupa.position = ccp(0, winSize.height);
        supasupa.posVar = ccp(supasupa.posVar.x, winSize.height);
        supasupa.startSize *= 0.5;
        supasupa.endSize *= 1;
        supasupa.speed *= 0.5;
        [self addChild:supasupa z:1];
	}
	
	return self;
}

-(void)doSomething: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:.3 scene:[HelloWorldLayer scene] ]];
}

@end
