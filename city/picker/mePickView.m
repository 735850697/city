//
//  mePickView.m
//  city
//
//  Created by dbjyz on 15/12/25.
//  Copyright © 2015年 dbjyz. All rights reserved.
//

#import "mePickView.h"
@interface mePickView()<UIPickerViewDataSource,UIPickerViewDelegate>
//数据
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;

//视图
@property(strong, nonatomic)UIPickerView * pickerView;
@end

@implementation mePickView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self getPickerData];
        [self addView];
        
    }
    return self;
}

//初始化视图
-(void)addView{
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-35)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self addSubview:_pickerView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, CGRectGetMaxY(_pickerView.frame), self.bounds.size.width, 35);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(selectjia) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

//选择城市
-(void)selectjia{
    NSLog(@"城市 == %@%@%@",[self.provinceArray objectAtIndex:[self.pickerView selectedRowInComponent:0]],[self.cityArray objectAtIndex:[self.pickerView selectedRowInComponent:1]],[self.townArray objectAtIndex:[self.pickerView selectedRowInComponent:2]]);
    NSString * city = [NSString stringWithFormat:@"%@%@%@",[self.provinceArray objectAtIndex:[self.pickerView selectedRowInComponent:0]],[self.cityArray objectAtIndex:[self.pickerView selectedRowInComponent:1]],[self.townArray objectAtIndex:[self.pickerView selectedRowInComponent:2]]];
    [self.delegate selectCity:city];
}




#pragma pickView的代理方法
- (void)getPickerData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
}


#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 110;
    } else if (component == 1) {
        return 100;
    } else {
        return 110;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
}


@end
