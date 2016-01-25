//
//  ViewController.m
//  city
//
//  Created by dbjyz on 15/12/25.
//  Copyright © 2015年 dbjyz. All rights reserved.
//

#import "ViewController.h"
#import "mePickView.h"

@interface ViewController ()<mePickViewDelegate>
@property(nonatomic, weak)UILabel * label;
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;

@property(nonatomic, strong)mePickView * pickView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(00,120, self.view.bounds.size.width, 45)];
    label.backgroundColor = [UIColor greenColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.label = label;
    [self. view addSubview:label];
    
    _pickView = [[mePickView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+10, self.view.bounds.size.width, 180)];
    _pickView.backgroundColor = [UIColor yellowColor];
    _pickView.delegate = self;
    [self.view addSubview:_pickView];
}

-(void)selectCity:(NSString *)city{
    self.label.text = city;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
