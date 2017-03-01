# LJAreaPicker中国大陆地区选择器

## 安装方法:

    只要把LJArea里面所有的玩意儿扔进工程就好了.. 没有pod install.. 无任何依赖  一切只如初见 一拉一import就好

## 使用方法:

1/先初始化个单例:

     _picker = [LJAreaPickerView shareLJArea];

2/再....

    [_picker initWithPickerColor:[UIColor whiteColor]  //底色
                CloseButtonColor:[UIColor blueColor]   //关闭按钮颜色
                        showView:self.view             //在哪一个视窗展示出来
                         inBlock:^(id returnValue) {   //回调block(闭包)
        //获取结果字符串的地方(一个字符串)
        self.label.text = returnValue;

    }];
