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

@synthesize numLocked;

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
        _next_count_to_add_circles = 10;
        numLocked = 0;

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
    
    if (numLocked == 3) {
        
    }
    else {
        gameTime += deltaTime;
        
        for (CircleClass *a_circle in _circles) {
            if (a_circle.isVisible == false) {
                [self addPoint];
                [self removeChild:a_circle];
                [_circles removeObject:a_circle];
                [_total_circles_ever removeObject:a_circle];
            }
            
            if (a_circle.isLocked == true) {
                [_circles removeObject:a_circle];
                numLocked++;
            }
        }
        
        if (numLocked == 3) {
            [self endScene];
        }
        else {
            int intervalOfTen = (int)ceil(gameTime) % 10;
            
            if (intervalOfTen == 0 && (int)ceil(gameTime) == _next_count_to_add_circles) {
                _num_circles_at_a_time += 1;
                _next_count_to_add_circles += 10;
            }
            
            // create a circle
            if ([_circles count] == 0) {
                for (int i = 0; i < _num_circles_at_a_time; i++) {
                    CircleClass *new_class = [CircleClass node];
                    CCLayer *layer = new_class;
                    CGSize size = [[CCDirector sharedDirector] winSize];
                    
                    while (true) {
                        bool breakOut = true;
                        for (CircleClass *circle in _total_circles_ever) {
                            float distance = pow(circle._x_location - new_class._x_location, 2) + pow(circle._y_location - new_class._y_location, 2);
                            
                            distance = sqrt(distance);
                            
                            if (distance <= [circle _correct_band]) {
                                // in a circle
                                breakOut = false;
                                
                                new_class._x_location = arc4random_uniform(size.width - 20);
                                new_class._y_location = arc4random_uniform(size.height - 20);
                            }
                        }
                        
                        if (breakOut == true) {
                            break;
                        }
                    }
                    
                    [self addChild:layer];
                    [_circles addObject:layer];
                    [_total_circles_ever addObject:layer];
                }
            }
            
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
    [scoreLabel setString:[NSString stringWithFormat:@"%d", score]];
    [scoreLabel setFontSize:48.0];
}

-(void)doSomething: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:.3 scene:[HelloWorldLayer scene] ]];
}

@end



