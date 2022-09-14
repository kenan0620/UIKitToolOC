# UIKitToolOC

[![CI Status](https://img.shields.io/travis/kenan/UIKitToolOC.svg?style=flat)](https://travis-ci.org/kenan/UIKitToolOC)
[![Version](https://img.shields.io/cocoapods/v/UIKitToolOC.svg?style=flat)](https://cocoapods.org/pods/UIKitToolOC)
[![License](https://img.shields.io/cocoapods/l/UIKitToolOC.svg?style=flat)](https://cocoapods.org/pods/UIKitToolOC)
[![Platform](https://img.shields.io/cocoapods/p/UIKitToolOC.svg?style=flat)](https://cocoapods.org/pods/UIKitToolOC)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

UIKitToolOC is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'UIKitToolOC'
```

## Usage

TextSwitch Masonry
```
TextSwitch *switch  = [[TextSwitch alloc] init];
switch.style = SwitchStyleNoBorder;
switch.onTintColor = [UIColor colorWithRed:0/255.0 green:102/255.0 blue:255/255.0 alpha:1.0];
switch.tintColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
switch.thumbTintColor = [UIColor whiteColor];
switch.onText = @"是";
switch.offText = @"否";
switch.textFont = [UIFont systemFontOfSize:14 weight:(UIFontWeightRegular)];
[switch addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
[self.view addSubview:switch];
[switch mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.view);
    make.size.mas_equalTo(CGSizeMake(67, 32));
}];
```

TextSwitch Frame
```
TextSwitch *switch  = [[TextSwitch alloc] initWithFrame:CGRectMake(0, 0, 67, 32)];
```

## Author

kenan, coenen@aliyun.com

## License

UIKitToolOC is available under the MIT license. See the LICENSE file for more info.
