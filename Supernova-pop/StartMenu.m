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
        CGSize winSize = [CCDirector sharedDirector].winSize;

		CCMenu * myMenu = [CCMenu menuWithItems:nil];
//        CCMenuItemImage *menuItem1 = [CCMenuItemImage itemWithNormalImage:@"start_button.png"
//                                                            selectedImage: @"start_button.png"
//                                                                   target:self
//                                                                 selector:@selector(doSomething:)];
//        [myMenu addChild:menuItem1];
        [CCMenuItemFont setFontName:@"Courier New"];
        [CCMenuItemFont setFontSize:80];
        
        CCMenuItem *Resume= [CCMenuItemFont itemWithString:@"Start"
                                                    target:self
                                                  selector:@selector(doSomething:)];
        [CCMenuItemFont setFontSize:40];

        CCMenuItem *Quit = [CCMenuItemFont itemWithString:@"How To Play"
                                                   target:self selector:@selector(doSomething:)];
        
        CCMenu *menu= [CCMenu menuWithItems: Resume, Quit, nil];
        menu.position = ccp(winSize.width/2, winSize.height/2);
        [menu alignItemsVerticallyWithPadding:13.5f];

        [self addChild:menu];
        
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
        
        //animate title
        
        if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
            ([UIScreen mainScreen].scale == 2.0)) {
            // Retina display
            CCSprite *mySprite = [CCSprite spriteWithFile:@"super@2x.png"];
            mySprite.scale = .8;
            CCSprite *popSprite = [CCSprite spriteWithFile:@"pop@2x.png"];
            mySprite.position = ccp(0,0);
            [self addChild:mySprite];
            [mySprite runAction: [CCMoveBy actionWithDuration:.9 position:ccp(winSize.width*.50,winSize.width*.60)]];
            
            popSprite.position = ccp(0,0);
            [self addChild:popSprite];
            popSprite.rotation = -25;
            id action1 = [CCDelayTime actionWithDuration:1];
            id action2 = [CCMoveBy actionWithDuration:.40 position:ccp(winSize.width*.85,winSize.width*.52)];
            [popSprite runAction: [CCSequence actions:action1, action2, nil]];
        } else {
            // non-Retina display
            CCSprite *mySprite = [CCSprite spriteWithFile:@"cooltext1162281600bb.png"];
            CCSprite *popSprite = [CCSprite spriteWithFile:@"poptext.png"];
            mySprite.position = ccp(0,0);
            [self addChild:mySprite];
            [mySprite runAction: [CCMoveBy actionWithDuration:.9 position:ccp(winSize.width*.45,winSize.width*.60)]];
            
            popSprite.position = ccp(0,0);
            [self addChild:popSprite];
            popSprite.rotation = -25;
            id action1 = [CCDelayTime actionWithDuration:1];
            id action2 = [CCMoveBy actionWithDuration:.40 position:ccp(winSize.width*.75,winSize.width*.50)];
            [popSprite runAction: [CCSequence actions:action1, action2, nil]];
        }
        
	}
	
	return self;
}

-(void)doSomething: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:.3 scene:[HelloWorldLayer scene] ]];
}

@end
