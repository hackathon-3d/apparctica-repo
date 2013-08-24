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

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

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
        _num_circles_at_a_time = 1;
        
        //Set the score to zero.
        score = 0;
        CGSize winSize = [CCDirector sharedDirector].winSize;
        //Create and add the score label as a child.
        scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:34];
        scoreLabel.position = ccp(winSize.width-30, winSize.height-30); //Middle of the screen...
        [self addChild:scoreLabel z:1];
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


-(void) draw
{
    
}

-(void) update:(ccTime)deltaTime
{
    //NSLog([[NSString alloc] initWithFormat:@"Time: %f", deltaTime]);
    gameTime += deltaTime;
    
    for (CircleClass *a_circle in _circles) {
        if (a_circle.isVisible == false || a_circle.isLocked == true) {
            [self addPoint];
            [self removeChild:a_circle];
            [_circles removeObject:a_circle];
        }
    }
    
    if ((int)ceil(gameTime) % 10 == 0) {
        _num_circles_at_a_time += 1;
    }
    
    // create a circle
    if ([_circles count] == 0) {
        NSLog([[NSString alloc] initWithFormat:@"Time: %i", (int)ceil(gameTime) % 10]);
        
        for (int i = 0; i < _num_circles_at_a_time; i++) {
            CCLayer *layer = [CircleClass node];
            [self addChild:layer];
            [_circles addObject:layer];
        }
    }
    
    
}

- (void)addPoint
{
    score = score + 1; //I think: score++; will also work.
    [scoreLabel setString:[NSString stringWithFormat:@"%d", score]];
}

@end



