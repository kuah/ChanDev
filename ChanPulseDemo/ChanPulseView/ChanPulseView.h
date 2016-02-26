//
//  ChanPulseView.h
//  PulseLoader
//
//  Created by 陈世翰 on 16/2/25.
//  Copyright © 2016年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ChanPurlseStyle) {
    ChanPurlseStyleRound = 0,
    ChanPurlseStyleSquare = 1
    
};

@interface ChanPulseView : UIView
/**
 *   总的动画时间
 */
@property (nonatomic,assign)CGFloat totalTime;
/**
 *   脉冲的频率 (脉冲波数)
 */
@property (nonatomic,assign)NSInteger pulseCount;
/**
 *   脉冲周期 两波脉冲相隔的时间
 */
@property (nonatomic,assign)CGFloat pulseCycle;
/**
 *   脉冲的范围，倍数
 */
@property (nonatomic,assign)CGFloat multiple;

/**
 *   是否在脉冲
 */
@property (nonatomic,assign,readonly)BOOL isPulsing;


-(id)initWithFrame:(CGRect)frame withColor:(UIColor *)color;

///当pulseCycle pulseCount的积等于totaltime的时候,动画就会连贯起来
-(id)initWithFrame:(CGRect)frame TotalTime:(CGFloat)totalTime PulseCount:(NSInteger)PulseCount PulseCycle:(CGFloat)pulseCycle Mutiple:(CGFloat)multiple StartAlpha:(CGFloat)startAlpha EndtAlpha:(CGFloat)endAlpha Color:(UIColor *)color Style:(ChanPurlseStyle)style;

- (void)startToPulse;
- (void)stopPulsingAnimation;

@end
