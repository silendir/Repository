//
//  ViewController.m
//  LJAreaPickerView
//
//  Created by silen on 2017/2/23.
//  Copyright © 2017年 silen. All rights reserved.
//
#import "LJArea/LJAreaPickerView.h"
#import "ViewController.h"

@interface ViewController ()
    @property (nonatomic,strong) LJAreaPickerView* picker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _picker = [LJAreaPickerView shareLJArea];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)dddd:(id)sender {
    [_picker initWithPickerColor:[UIColor whiteColor] CloseButtonColor:[UIColor blueColor] showView:self.view inBlock:^(id returnValue) {
        self.label.text = returnValue;
    }];
     
}


@end
