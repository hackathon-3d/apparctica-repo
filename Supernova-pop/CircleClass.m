//
//  CircleClass.m
//  Supernova-pop
//
//  Created by Jonathan Mayhak on 8/23/13.
//  Copyright 2013 Jason Rikard. All rights reserved.
//

#import "CircleClass.h"
#import "CCTouchDispatcher.h"

@implementation CircleClass
// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
           
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		[self scheduleUpdateWithPriority:-10];
        CGSize size = [[CCDirector sharedDirector] winSize];

        self->_size_of_circle = 1;
        self->_x_location = arc4random_uniform(size.width - 20);
        self->_y_location = arc4random_uniform(size.height - 20);
        self->_correct_band = 25 + [self randomFloatBetween:50 and:250];
        self->_is_visible = true;
        self->_is_locked = false;
        self->_rate_of_growth = [self randomFloatBetween:0.8 and:2];
        
        self.isTouchEnabled = YES;
        sunFire = [CCParticleSystemQuad particleWithFile:@"power_suck.plist"];
        sunFire.position = ccp(self->_x_location, self->_y_location);
        sunFire.endRadius = 0;
        // sunFire.posVar = ccp(supasupa.posVar.x, winSize.height);
        //    supasupa.startSize *= 0.5;
        //    supasupa.endSize *= 1;
        //    supasupa.speed *= 0.5;
        [self addChild:sunFire z:1];
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

    // red
    ccDrawColor4F(255, 0, 0, 0);
    ccDrawSolidCircle(ccp(self->_x_location, self->_y_location), self->_size_of_circle, 60);

    
    for (int i = 0; i <= 30; i++) {
        ccDrawColor4F(0, 0, 255, 0);
        ccDrawCircle(ccp(self->_x_location, self->_y_location), self->_correct_band - i, CC_DEGREES_TO_RADIANS(360), 60, NO);
    }

}

- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

-(void) update:(ccTime)deltaTime
{
    if (self->_size_of_circle > self->_correct_band) {
        self->_is_locked = true;
    }
    
    
    if (self->_is_locked == false && self->_is_visible == true) {
        self->_size_of_circle = self->_size_of_circle + self->_rate_of_growth;
        sunFire.endRadius = self->_size_of_circle;
    }
    
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [self convertTouchToNodeSpace: touch];
    
    float distance = pow(self->_x_location - location.x, 2) + pow(self->_y_location - location.y, 2);
    
    distance = sqrt(distance);
    
    if (distance <= self->_size_of_circle) {
        // within the circle
        if (self->_size_of_circle <= self->_correct_band && self->_size_of_circle >= self->_correct_band - 30) {
            // the circle is by the band
            self->_is_visible = false;
        }
        else {
            // to early... not within the band
            self->_is_locked = true;
        }
        
    }
    
}

- (void)setInvisible:(CCNode *)node {
    node.visible = NO;
}


- (bool)isVisible {
    return self->_is_visible;
}

- (bool)isLocked {
    return self->_is_locked;
}

@end
