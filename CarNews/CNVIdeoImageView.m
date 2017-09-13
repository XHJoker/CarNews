//
//  CNVIdeoImageView.m
//  CarNews
//
//  Created by SiYugui on 2017/8/25.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "CNVIdeoImageView.h"
#import <Masonry.h>
#import "EdtMacro.h"

@interface CNVIdeoImageView ()
@property (nonatomic,weak) UIButton * playButton;
@end

@implementation CNVIdeoImageView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self.playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
    return self;
}

- (UIButton *)playButton {
    if (!_playButton) {
        UIButton *play = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:play];
        _playButton = play;
        WeakSelf(weakSelf);
        [play mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.center.equalTo(weakSelf);
        }];
        [_playButton addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (void)playBtnClick:(UIButton *)btn {
    if (self.videoTableCellVideoDidBeginPlayHandle) {
        self.videoTableCellVideoDidBeginPlayHandle(btn);
    }
}

@end
