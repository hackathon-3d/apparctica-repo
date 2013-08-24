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
        _next_count_to_add_circles = 10;
        numLocked = 0;
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
        if (a_circle.isVisible == false) {
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
                for (CircleClass *circle in _circles) {
                    float distance = pow(circle._x_location - new_class._x_location, 2) + pow(circle._y_location - new_class._y_location, 2);
                    
                    distance = sqrt(distance);
                    
                    if (distance <= [circle _size_of_circle]) {
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
        }
    }
    
    
}

- (void)endScene {
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    NSString *message = @"You lose!";

    CCLabelBMFont *label;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        label = [CCLabelBMFont labelWithString:message fntFile:@"Arial-hd.fnt"];
    } else {
        label = [CCLabelBMFont labelWithString:message fntFile:@"Arial.fnt"];
    }
    label.scale = 0.1;
    label.position = ccp(winSize.width/2, winSize.height * 0.6);
    [self addChild:label];
    
}

@end



