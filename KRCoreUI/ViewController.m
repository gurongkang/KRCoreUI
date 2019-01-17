//
//  ViewController.m
//  KRCoreUI
//
//  Created by RK on 2018/12/22.
//  Copyright © 2018年 RK. All rights reserved.
//

#import "ViewController.h"
#import "KRImageExampleViewController.h"

static NSString *kCoreUITableViewCell = @"kCoreUITableViewCell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *exampleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCoreUITableViewCell];
    
    _exampleArray = @[@"图片处理"];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.frame;
}

#pragma mark tableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCoreUITableViewCell forIndexPath:indexPath];
    cell.textLabel.text = _exampleArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _exampleArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        KRImageExampleViewController *imageVC = [[KRImageExampleViewController alloc]init];
        [self.navigationController pushViewController:imageVC animated:YES];
    }
    
}

#pragma mark lazy

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 40;
    }
    
    return _tableView;
}

@end
