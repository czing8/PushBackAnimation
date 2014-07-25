//
//  ViewController.m
//  PushBackAnimation
//
//  Created by Vols on 14-7-25.
//  Copyright (c) 2014年 Vols. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView * primaryView;
@property (nonatomic, strong) UIView * secondaryView;
@property (nonatomic, strong) UIView * primaryShadeView;

@property (nonatomic, strong) UIButton * button;
@property (nonatomic, strong) UIButton * udoButton;



@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    _secondaryView.frame = CGRectMake(0, _primaryView.frame.size.height, _secondaryView.frame.size.width, _secondaryView.frame.size.height);
    _secondaryView.hidden = false;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.primaryShadeView];
    [self.view addSubview:self.primaryView];
    [self.view addSubview:self.secondaryView];

}



#pragma mark - properties

- (UIView *)primaryView{
    if (!_primaryView) {
        _primaryView = [[UIView alloc] initWithFrame:self.view.bounds];
        _primaryView.backgroundColor = [UIColor whiteColor];
        [_primaryView addSubview:self.button];
    }
    return _primaryView;
}

- (UIView *)secondaryView{
    if (!_secondaryView) {
        
        CGRect frame = CGRectMake(0, kSCREEN_SIZE.height - 246, kSCREEN_SIZE.width, 246);
        _secondaryView = [[UIView alloc] initWithFrame:frame];
        _secondaryView.backgroundColor = [UIColor redColor];
        [_secondaryView addSubview:self.udoButton];

    }
    return _secondaryView;
}

- (UIView *)primaryShadeView{
    if (!_primaryShadeView) {
        _primaryShadeView = [[UIView alloc] initWithFrame:self.view.bounds];
        _primaryShadeView.alpha = 0;
        _primaryShadeView.backgroundColor = [UIColor blackColor];
    }
    return _primaryShadeView;
}

- (UIButton *)button{
    if (!_button) {
        _button= [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(120, 100, 80, 40);
        _button.backgroundColor = [UIColor orangeColor];
        [_button setTitle:@"GO" forState:UIControlStateNormal];
        _button.layer.cornerRadius = 5.0;
        [_button addTarget:self action:@selector(goAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UIButton *)udoButton{
    if (!_udoButton) {
        _udoButton= [UIButton buttonWithType:UIButtonTypeCustom];
        _udoButton.frame = CGRectMake(120, 100, 80, 40);
        _udoButton.backgroundColor = [UIColor orangeColor];
        [_udoButton setTitle:@"Undo" forState:UIControlStateNormal];
        _udoButton.layer.cornerRadius = 5.0;
        [_udoButton addTarget:self action:@selector(udoAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _udoButton;
}


- (void)goAction:(UIButton *)button{
    
    _primaryView.userInteractionEnabled=NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        _secondaryView.frame = CGRectMake(0, _primaryView.frame.size.height - _secondaryView.frame.size.height, _secondaryView.frame.size.width, _secondaryView.frame.size.height);
        
        CALayer *layer = _primaryView.layer;
        layer.zPosition = -4000;
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / -300;
        layer.shadowOpacity = 0.01;
        layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, 10.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
        
        _primaryShadeView.alpha = 0.35;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _primaryView.transform = CGAffineTransformMakeScale(0.9, 0.9);
            
            _primaryShadeView.alpha = 0.5;
        }];
    }];
}


- (void)udoAction:(UIButton *)button{
    _primaryView.userInteractionEnabled=YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        CALayer *layer = _primaryView.layer;
        layer.zPosition = -4000;
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / 300;
        layer.shadowOpacity = 0.01;
        layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, -10.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
        
        _primaryShadeView.alpha = 0.35;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _primaryView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
            _primaryShadeView.alpha = 0.0;
            
            _secondaryView.frame = CGRectMake(0, _primaryView.frame.size.height, _secondaryView.frame.size.width, _secondaryView.frame.size.height);
        }];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
