//
//  HelloWorldLayer.m
//  Supernova-pop
//
//  Created by Jason Rikard on 8/23/13.
//  Copyright Jason Rikard 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "CircleClass.h"
#import "PauseScene.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

@synthesize numLocked;
@synthesize rateOfCircles, _total_circles_ever;

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		[self scheduleUpdate];
        
        _circles = [[CCArray alloc] init];
        _total_circles_ever = [[NSMutableArray alloc] init];
        _num_circles_at_a_time = 1;
        
        //Set the score to zero.
        score = 0;
        CGSize winSize = [CCDirector sharedDirector].winSize;
        //Create and add the score label as a child.
        scoreLabel = [CCLabelTTF labelWithString:@"Score: 0" fontName:@"Marker Felt" fontSize:34];
        scoreLabel.position = ccp(winSize.width-120, winSize.height-30); //Middle of the screen...
        [scoreLabel setFontSize:64.0];
        [self addChild:scoreLabel z:1];
        _next_count_to_add_circles = 5;
        numLocked = 0;
        rateOfCircles = 3;

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
        
        //menu
		CCMenuItemImage *Pause = [CCMenuItemImage itemWithNormalImage:@"pause.png"
                                                   selectedImage: @"pause.png"
                                                          target:self
                                                        selector:@selector(pause:)];
//        CCMenuItemImage *menuItem1 = [CCMenuItemImage itemWithNormalImage:@"start_button.png"
//                                                            selectedImage: @"start_button.png"
//                                                                   target:self
//                                                                 selector:@selector(doSomething:)];
        CCMenu *PauseButton = [CCMenu menuWithItems: Pause, nil];
        PauseButton.position = ccp(40, winSize.height-40);
        //[self schedule:@selector(tick:) interval:1.0f/60.0f];
        [self addChild:PauseButton z:1000];
        
        
       

        [self schedule:@selector(addCircles:) interval:rateOfCircles];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

-(void) addCircles: (ccTime) delta
{
    //NSLog([[NSString alloc] initWithFormat:@"delta: %f", (float)delta ]);
    CircleClass *new_class = [CircleClass node];
    CCLayer *layer = new_class;
    
    [self addChild:layer];
    [_circles addObject:layer];
    [_total_circles_ever addObject:layer];
}


-(void) draw
{
    
}

-(void) update:(ccTime)deltaTime
{
    //NSLog([[NSString alloc] initWithFormat:@"Time: %f", deltaTime]);
    
    //NSLog([[NSString alloc] initWithFormat:@"Count: %i", [_total_circles_ever count]]);
    if ([_total_circles_ever count] > _next_count_to_add_circles && [_total_circles_ever count] % 5 == 0) {
        [self unschedule:@selector(addCircles)];
        
        rateOfCircles = rateOfCircles - .3;
        if (rateOfCircles < .5) {
            rateOfCircles = .5;
        }
        
        [self schedule:@selector(addCircles:) interval:rateOfCircles];
        _next_count_to_add_circles += 5;
    }
    
    if (numLocked == 3) {
        // game done
    }
    else {
        gameTime += deltaTime;
        
        for (CircleClass *a_circle in _circles) {
            if (a_circle.isVisible == false) {
                [self addPoint];
                [self removeChild:a_circle];
                [_circles removeObject:a_circle];
            }
            
            if (a_circle.isLocked == true) {
                [_circles removeObject:a_circle];
                numLocked++;
            }
        }
        
        if (numLocked == 3) {
            [self endScene];
        }
    }
    
    
        
    
}

- (void)endScene {
    
    CCMenu * myMenu = [CCMenu menuWithItems:nil];
    CCMenuItemImage *menuItem1 = [CCMenuItemImage itemWithNormalImage:@"restart_button.png"
                                                        selectedImage: @"restart_button.png"
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
    supasupa.endSize *= 0.8;
    supasupa.speed *= 0.5;
    [self addChild:supasupa z:1];
    
}

- (void)addPoint
{
    score = score + 1; //I think: score++; will also work.
    [scoreLabel setString:[NSString stringWithFormat:@"Score: %d", score]];
    
}

-(void)doSomething: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] startAnimation];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:.3 scene:[HelloWorldLayer scene] ]];
}

-(void) pause: (CCMenuItem  *) menuItem

{
    
    [[CCDirector sharedDirector] pushScene:[PauseScene node]];
    
//    [[CCDirector sharedDirector] stopAnimation];
//    [[CCDirector sharedDirector] pause];
    
}

- (void) applicationDidEnterBackground:(UIApplication *)application
{
    [[CCDirector sharedDirector] stopAnimation];
    [[CCDirector sharedDirector] pause];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    [[CCDirector sharedDirector] stopAnimation];
    [[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[CCDirector sharedDirector] stopAnimation]; // call this to make sure you don't start a second display link!
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] startAnimation];
}

@end



