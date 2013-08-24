//
//  CircleClass.h
//  Supernova-pop
//
//  Created by Jonathan Mayhak on 8/23/13.
//  Copyright 2013 Jason Rikard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CircleClass : CCLayer {
    float _size_of_circle;
    float _x_location;
    float _y_location;
    float _correct_band;
    float _rate_of_growth;
    bool _is_visible;
    bool _is_locked;
    
}

-(bool) isVisible;
-(bool) isLocked;

@property float _size_of_circle;
@property float _x_location;
@property float _y_location;
@property float _correct_band;
@property float _rate_growth;
@property bool _is_visible;
@property bool _is_locked;
@property bool is_fading;
@property NSDate *circleSpawnDate;
@property int lastTimeScheduledBefore;
@property CCParticleSystemQuad *sunFire;
@property float opacity;
@property int fadeOutRate;
@property int currentOpacity;

@property float nextXLocation;
@property float nextYLocation;

+(CCScene *) scene;

@end
