//
//  ViewController.m
//  ChanPulseDemo
//
//  Created by 陈世翰 on 16/2/26.
//  Copyright © 2016年 陈世翰. All rights reserved.
//

#import "ViewController.h"
#import "ChanPulseView.h"

@interface ViewController ()
/**
 *   <#decr#>
 */
@property (nonatomic,strong)ChanPulseView *pulseLoader;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//     ChanPulseView *pulseLoader = [[ChanPulseView alloc]initWithFrame:<#(CGRect)#> TotalTime:<#(CGFloat)#> PulseCount:<#(NSInteger)#> PulseCycle:<#(CGFloat)#> Mutiple:<#(CGFloat)#> StartAlpha:<#(CGFloat)#> EndtAlpha:<#(CGFloat)#> Color:<#(UIColor *)#> Style:<#(ChanPurlseStyle)#>
    
    ChanPulseView *pulseLoader = [[ChanPulseView alloc]initWithFrame:CGRectMake(0, 0, 80, 80) withColor:[UIColor redColor]];
    pulseLoader.center = self.view.center;
    [self.view addSubview:pulseLoader];
    _pulseLoader = pulseLoader;
    
    [pulseLoader startToPulse];
    
    UIButton *button = [[UIButton alloc]initWithFrame:pulseLoader.bounds];
    [button setImage:[UIImage imageNamed:@"chan.png"] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 0.5*button.frame.size.width;
    button.center = self.view.center;
    [button addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)btn:(id)sender{
    if (_pulseLoader.isPulsing) {
        [_pulseLoader stopPulsingAnimation];
    }else{
        [_pulseLoader startToPulse];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
