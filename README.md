# LJAreaPicker中国大陆地区选择器

## 安装方法:

    只要把LJArea里面所有的玩意儿扔进工程就好了.. 没有pod install.. 遵循屎一样安装体验,一拉就好

## 使用方法:

1/先初始化个单例:

     _picker = [PickerViewController shareLJArea];

2/再....

    [_picker initWithPickerColor:[UIColor whiteColor]  //底色
                CloseButtonColor:[UIColor blueColor]   //关闭按钮颜色
      showView:self.view inBlock:^(id returnValue) {
        //获取结果字符串的地方(一个字符串)
        self.label.text = returnValue;

    }];
