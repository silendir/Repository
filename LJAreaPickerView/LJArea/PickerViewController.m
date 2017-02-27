//
//  PickerViewController.m
//  CBProjects
//
//  Created by silen on 2017/2/23.
//  Copyright © 2017年 CB. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
    //piker
    @property (nonatomic,strong)UIView* pickerBackGround;
    @property (nonatomic,strong) UIPickerView* pickerView;
    @property (nonatomic,strong) NSArray* pickerArray;
    @property(nonatomic,strong)NSMutableArray* pickerSelectRow;//记录picker选择值
    @property (nonatomic,copy)NSString* state;
    @property (nonatomic,copy)NSString* city;
    @property (nonatomic,copy)NSString* areas;
    @property (nonatomic,copy)NSString* area;
    @property (nonatomic,strong)NSMutableArray* stateArray;
    @property (nonatomic,strong)NSMutableArray* cityArray;
    @property (nonatomic,strong)NSMutableArray* areasArray;
@end

@implementation PickerViewController

- (void)initWithPickerColor:(UIColor*)pickerColor
           CloseButtonColor:(UIColor*)closeButtonColor
                   showView:(UIView*)view
                    inBlock:(ReturnValueBlock)block{
    
    
    _closeButtonTitleColor = closeButtonColor;
    _pickerViewBackgroundColor = pickerColor;
    _showView = view;
    if (block) {
        self.block = block;
    }
    //一个记录上次选择值的Picker刻度数组
    if (!self.pickerSelectRow) {
        self.pickerSelectRow = @[@"0",@"0",@"0"].mutableCopy;
    }
    if (!self.state) {
        self.state = @"";
        self.city  = @"";
        self.areas = @"";
        
    }
    if (!self.stateArray) {
        _stateArray = [NSMutableArray array];
        _cityArray = [NSMutableArray array];
        _areasArray = [NSMutableArray array];
        NSArray* addressArray = [self areaData];//从plist加载区域表
        for (NSDictionary* dic in addressArray) {
            [self.stateArray addObject:dic];
        }
        self.cityArray = [[[self.stateArray firstObject] valueForKey:@"cities"] mutableCopy];
        self.areasArray = [[[self.cityArray firstObject] valueForKey:@"areas"] mutableCopy];
    }
    
    
    [self didClickArea];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
//- (IBAction)didClickLabel:(id)sender {
//    [self didClickArea];
//}


#pragma mark 点击地区按钮(弹出pickerView)
- (void)didClickArea{
    NSLog(@"%@,%@,%@",self.state,self.city,self.areas);
    NSLog(@"didClickArea:");
    [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    if (self.pickerBackGround) {
        
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.pickerBackGround.frame = CGRectMake(0, (SCREEN_HEIGHT ), SCREEN_WIDTH, 216);
        } completion:^(BOOL finished) {
            
            [weakSelf.pickerBackGround removeFromSuperview];
            weakSelf.pickerBackGround = nil;
            //            self.pickerView = nil;
        }];
        
    }else{
        _pickerBackGround = [[UIView alloc]initWithFrame:CGRectMake(0, (SCREEN_HEIGHT ), SCREEN_WIDTH, 216)];
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 30, self.pickerBackGround.bounds.size.width, self.pickerBackGround.bounds.size.height-30)];
        self.pickerView.backgroundColor = self.pickerViewBackgroundColor;
        self.pickerView.showsSelectionIndicator = YES;
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        [self.pickerBackGround addSubview:self.pickerView];
        UIView* banner = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        banner.backgroundColor = [UIColor whiteColor];
        banner.layer.borderColor = [UIColor lightGrayColor].CGColor;
        banner.layer.borderWidth = 0.5;
        UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 0, 60, 30)];
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        [btn setTitleColor:self.closeButtonTitleColor forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor clearColor]];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addTarget:self action:@selector(didClickArea) forControlEvents:UIControlEventTouchUpInside];
        
        [banner addSubview:btn];
        
        self.pickerView.clipsToBounds = YES;
        [self.pickerBackGround addSubview:banner];
        [_showView addSubview:self.pickerBackGround];
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.pickerBackGround.frame = CGRectMake(0, (SCREEN_HEIGHT - 216-64), SCREEN_WIDTH, 216);
        } completion:^(BOOL finished) {
            
        }];
    }
    NSLog(@"都跳到哪里%@",self.pickerSelectRow);
    [self.pickerView selectRow:[NSString stringWithFormat:@"%@", self.pickerSelectRow[0]].integerValue inComponent:0 animated:NO];
    [self.pickerView selectRow:[NSString stringWithFormat:@"%@", self.pickerSelectRow[1]].integerValue inComponent:1 animated:NO];
    [self.pickerView selectRow:[NSString stringWithFormat:@"%@", self.pickerSelectRow[2]].integerValue inComponent:2 animated:NO];
    //打开就选中北京通州
    if ([self.area isEqualToString:@""] || self.area == nil) {
        self.area = @"北京通州";
        if (self.block) {
            self.block(self.area);
        }
        [self.pickerView reloadAllComponents];
        
    }
    
}
#pragma mark - PickerView Delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger i =0;
    switch (component) {
        case 0:
        i = self.stateArray.count;
        break;
        case 1:
        i = self.cityArray.count;
        break;
        case 2:
        i = self.areasArray.count;
        break;
        default:
        break;
    }
    return i;
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //NSLog(@"row:%ld", (long)row);
    NSString* str  = @"";
    
    switch (component) {
        case 0:
        str = [self.stateArray[row] valueForKey: @"state"];
        self.state = str;
        break;
        case 1:
        str = [self.cityArray[row] valueForKey: @"city"];
        self.city = str;
        break;
        case 2:
        if (self.areasArray.count>0) {
            str = self.areasArray[row] ;
            self.areas = str;
        }
        
        break;
        default:
        break;
    }
    
    return str;
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        self.state =  [self.stateArray[row]valueForKey:@"state"];
        [self.cityArray removeAllObjects];
        self.cityArray = [[self.stateArray[row]valueForKey:@"cities"] mutableCopy];
        
        self.city =  [self.cityArray[0]valueForKey:@"city"];
        [self.areasArray removeAllObjects];
        self.areasArray = [[self.cityArray[0]valueForKey:@"areas"] mutableCopy];
        
        if (self.areasArray.count > 0){
            self.areas =  self.areasArray[0];
        }else{
            self.areas = @"";
        }
        [self.pickerView selectRow:0 inComponent:1 animated:NO];
        [self.pickerView selectRow:0 inComponent:2 animated:NO];
        
    }else if (component == 1) {
        self.city =  [self.cityArray[row]valueForKey:@"city"];
        [self.areasArray removeAllObjects];
        self.areasArray = [[self.cityArray[row]valueForKey:@"areas"] mutableCopy];
        
        if (self.areasArray.count > 0){
            self.areas =  self.areasArray[0];
        }else{
            self.areas = @"";
        }
        [self.pickerView selectRow:0 inComponent:2 animated:NO];
    }else if (component == 2) {
        if (self.areasArray.count > 0){
            self.areas =  self.areasArray[row];
        }else{
            self.areas = @"";
        }
    }
    self.pickerSelectRow[component] =[NSString stringWithFormat:@"%ld",(long)row];
    self.area = [[self.state stringByAppendingString:self.city] stringByAppendingString:self.areas];
    if (self.block) {
        self.block(self.area);
    }
    //self.label.text = self.area;
    //[self setupInterFace];
    //    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:4 inSection:0];
    //    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    [self.pickerView reloadAllComponents];
    NSLog(@"%@,%@,%@",self.state,self.city,self.areas);
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}
    
#pragma mark - 获取地址plist文件信息
- (NSArray *)areaData
    {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:[self makeAppFilePath:@"area.plist"]];
        return [self modelsFromInfos:array];
        
    }
    
- (NSString*) makeAppFilePath:(NSString*) filename{
    NSString *appDirectory = [[NSBundle mainBundle] resourcePath];
    NSString *filePath=[appDirectory stringByAppendingPathComponent:filename];
    return filePath;
}
    
- (NSArray *)modelsFromInfos:(NSArray *)infos
    {
        NSInteger count = [infos count];
        
        NSMutableArray *mutModels = [[NSMutableArray alloc] initWithCapacity:count];
        for (NSInteger i = 0; i < count; i++) {
            
            id model = [[[NSDictionary class] alloc] initWithDictionary:[infos objectAtIndex:i]];
            [mutModels addObject:model];
            
        }
        NSArray *models = [NSArray arrayWithArray:mutModels];
        
        return models;
    }
#pragma mark - 单例
+(instancetype)shareLJArea{
        static PickerViewController *ljArea = nil;
        //给单例加了一个线程锁
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            ljArea = [[PickerViewController alloc] init];
        }); 
    return ljArea;
}
    

@end
