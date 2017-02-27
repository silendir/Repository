//
//  LJArea.h
//  CBProjects
//
//  Created by silen on 2017/2/23.
//  Copyright © 2017年 CB. All rights reserved.
//

//宏
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
typedef void (^ReturnValueBlock) (id returnValue);

#import <UIKit/UIKit.h>

@interface PickerViewController : UIViewController
//@property (weak, nonatomic) IBOutlet UILabel *label;//演示用的结果显示框
@property (nonatomic,strong)UIColor* closeButtonTitleColor;
@property (nonatomic,strong)UIColor* pickerViewBackgroundColor;
@property (nonatomic,strong)UIView* showView;
- (void)initWithPickerColor:(UIColor*)pickerColor
               CloseButtonColor:(UIColor*)closeButtonColor
                       showView:(UIView*)vie
                        inBlock:(ReturnValueBlock)block;
- (void)didClickArea;
@property (nonatomic,copy)ReturnValueBlock block;
+(instancetype)shareLJArea;
@end
