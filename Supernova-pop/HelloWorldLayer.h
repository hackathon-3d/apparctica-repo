//
//  HelloWorldLayer.h
//  Supernova-pop
//
//  Created by Jason Rikard on 8/23/13.
//  Copyright Jason Rikard 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    CGFloat gameTime;
    int score;
    CCLabelTTF *scoreLabel;
    CCLabelTTF *lifeLabel;
    CCArray *_circles;
    int _num_circles_at_a_time;
    int _next_count_to_add_circles;
    CCParticleSystemQuad *sunFire;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

- (void)endScene;
@property int numLocked;
@property NSMutableArray *_total_circles_ever;
@property CCSprite *lifeOne;
@property CCSprite *lifeTwo;
@property CCSprite *lifeThree;
@property int numToGoAfterEndGame;

-(void) endCircles;
- (void)addPoint;
-(void)doSomething: (CCMenuItem  *) menuItem;
-(void)addCircles: (ccTime)delta;

@property float rateOfCircles;


@end
