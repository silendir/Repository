//
//  ViewController.m
//  LJAreaPickerView
//
//  Created by silen on 2017/2/23.
//  Copyright © 2017年 silen. All rights reserved.
//
#import "PickerViewController.h"
#import "ViewController.h"

@interface ViewController ()
    @property (nonatomic,strong) PickerViewController* picker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _picker = [PickerViewController new];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dddd:(id)sender {
    
    [_picker initWithPickerColor:[UIColor whiteColor] CloseButtonColor:[UIColor blueColor] showView:self.view inBlock:^(id returnValue) {
        self.label.text = returnValue;
    }];
     
}


@end
