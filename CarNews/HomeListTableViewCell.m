//
//  HomeListTableViewCell.m
//  CarNews
//
//  Created by SiYugui on 2017/8/23.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "HomeListTableViewCell.h"

#import <Masonry.h>
#import "EdtMacro.h"
//#import <UIImageView+WebCache.h>
#import <UIImageView+YYWebImage.h>

@interface HomeListTableViewCell()
@property (nonatomic,strong) UIImageView *homeImageView;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *dateLab;
@property (nonatomic,strong) UILabel *replycountLab;
@end

@implementation HomeListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIImageView *)homeImageView{
    if (!_homeImageView) {
        _homeImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_homeImageView];
        [_homeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(5);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(60);
        }];
    }
    
    return _homeImageView;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = kBoldFont(15);
        _titleLab.numberOfLines = 0;
        [self.contentView addSubview:_titleLab];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(95);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(5);
            make.height.mas_equalTo(40);
        }];
    }
    
    return _titleLab;
}

-(UILabel *)dateLab{
    if (!_dateLab) {
        _dateLab = [[UILabel alloc] init];
        _dateLab.font = kFont(13);
        _dateLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_dateLab];
        [_dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(95);
            make.bottom.equalTo(self.contentView);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
        }];
    }
    return _dateLab;
}

-(UILabel *)replycountLab{
    if (!_replycountLab) {
        _replycountLab = [[UILabel alloc] init];
        _replycountLab.font = kFont(13);
        [_replycountLab setTextAlignment:NSTextAlignmentRight];
        _replycountLab.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_replycountLab];
        [_replycountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.bottom.equalTo(self.contentView);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(20);
        }];
    }
    return _replycountLab;
}

-(void)setCellWithModel:(HomeResultNewslistModel *)listModel{
    [self.homeImageView yy_setImageWithURL:[NSURL URLWithString:listModel.smallpic] placeholder:nil];
    self.titleLab.text = listModel.title;
    self.dateLab.text = listModel.time;
    self.replycountLab.text = [NSString stringWithFormat:@"点击%ld",listModel.replycount];
}

@end
