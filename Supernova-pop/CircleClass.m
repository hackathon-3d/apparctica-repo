//
//  CircleClass.m
//  Supernova-pop
//
//  Created by Jonathan Mayhak on 8/23/13.
//  Copyright 2013 Jason Rikard. All rights reserved.
//

#import "CircleClass.h"
#import "CCTouchDispatcher.h"

// Add to top of file
#define kNumAsteroids   15


@implementation CircleClass
// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CircleClass *layer = [CircleClass node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    // 'layer' is an autorelease object.
	CircleClass *layer1 = [CircleClass node];
	
	// add layer as a child to scene
	[scene addChild: layer1];

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
        
        _batchNode = [CCSpriteBatchNode batchNodeWithFile:@"Sprites.pvr.ccz"]; // 1
        [self addChild:_batchNode]; // 2
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Sprites.plist"]; // 3
        
        self->_size_of_circle = 20;
        self->_x_location = arc4random_uniform(size.width - 20);
        self->_y_location = arc4random_uniform(size.height - 20);
        
        _asteroids = [[CCArray alloc] initWithCapacity:kNumAsteroids];
        for(int i = 0; i < kNumAsteroids; ++i) {
            CCSprite *asteroid = [CCSprite spriteWithSpriteFrameName:@"asteroid.png"];
            asteroid.visible = NO;
            [_batchNode addChild:asteroid];
            [_asteroids addObject:asteroid];
        }
        
        self.isTouchEnabled = YES;
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
    
    ccDrawSolidCircle(ccp(self->_x_location, self->_y_location), self->_size_of_circle, 50);
    ccDrawColor4F(0.0f, 1.0f, 0.0f, 1.0f);
}

- (float)randomValueBetween:(float)low andValue:(float)high {
    return (((float) arc4random() / 0xFFFFFFFFu) * (high - low)) + low;
}

-(void) update:(ccTime)deltaTime
{
    //NSLog([[NSString alloc] initWithFormat:@"Time: %f", deltaTime]);
    //self->_size_of_circle = self->_size_of_circle + .1;
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    //float maxY = winSize.height - _ship.contentSize.height/2;
    //float minY = _ship.contentSize.height/2;
    
    //float newY = _ship.position.y + (_shipPointsPerSecY * dt);
    //newY = MIN(MAX(newY, minY), maxY);
    //_ship.position = ccp(_ship.position.x, newY);
    
    double curTime = CACurrentMediaTime();
    if (curTime > _nextAsteroidSpawn) {
        
        float randSecs = [self randomValueBetween:0.20 andValue:1.0];
        _nextAsteroidSpawn = randSecs + curTime;
        
        float randY = [self randomValueBetween:0.0 andValue:winSize.height];
        float randDuration = [self randomValueBetween:2.0 andValue:10.0];
        
        CCSprite *asteroid = [_asteroids objectAtIndex:_nextAsteroid];
        _nextAsteroid++;
        if (_nextAsteroid >= _asteroids.count) _nextAsteroid = 0;
        
        [asteroid stopAllActions];
        asteroid.position = ccp(winSize.width+asteroid.contentSize.width/2, randY);
        asteroid.visible = YES;
        [asteroid runAction:[CCSequence actions:
                             [CCMoveBy actionWithDuration:randDuration position:ccp(-winSize.width-asteroid.contentSize.width, 0)],
                             [CCCallFuncN actionWithTarget:self selector:@selector(setInvisible:)],
                             nil]];
        
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
        self->_size_of_circle = self->_size_of_circle + 20;
    }
}

- (void)setInvisible:(CCNode *)node {
    node.visible = NO;
}

@end
