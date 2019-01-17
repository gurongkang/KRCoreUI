//
//  KRImageExampleViewController.m
//  KRCoreUI
//
//  Created by RK on 2019/1/17.
//  Copyright © 2019年 RK. All rights reserved.
//

#import "KRImageExampleViewController.h"
#import "UIImage+KRClip.h"
#import "UIImage+TranslateColor.h"

@interface KRImageExampleViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *oriImageView;
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;

@end

@implementation KRImageExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)dealImage:(id)sender {
    UIImage *oriImage = [UIImage imageNamed:@"ori"];
    UIImage *resultImage = [UIImage imageProcess:oriImage];
    self.resultImageView.image = resultImage;
}

@end
