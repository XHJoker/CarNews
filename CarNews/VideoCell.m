//
//  VideoCell.m
//  CarNews
//
//  Created by SiYugui on 2017/8/25.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "VideoCell.h"
#import "CNVIdeoImageView.h"
#import "EdtMacro.h"
#import <Masonry.h>

@interface VideoCell ()
@property (nonatomic ,weak) UILabel *titleLab;
@property (nonatomic ,weak) UILabel *timeLab;
@property (nonatomic ,weak) CNVIdeoImageView *iconImageView;
@property (nonatomic ,weak) UILabel *desLab;
@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, copy) NSString *videoUrl;
@end

@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellFrame:(VideoCellFrame *)frame{
    
    self.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
    
    [self removeAllImages];
    
    self.titleLab.frame = frame.titleLableF;
    self.titleLab.text = frame.model.title;
    
    self.iconImageView.frame = frame.imageViewF;
    [self.iconImageView setImageWithUrl:frame.model.coverUrl placeHolder:nil];
    self.videoUrl = frame.model.mp4_url;
    self.desLab.frame = frame.videoDescriptionLabF;
    self.desLab.text = frame.model.videoDescription;
    
}

- (void)removeAllImages {
    
    [_iconImageView removeFromSuperview];
    _iconImageView.image = nil;
    _iconImageView = nil;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        UILabel *lab = [[UILabel alloc] init];
        lab.numberOfLines = 0;
        lab.font = kFont(15);
        [self.bgView addSubview:lab];
        _titleLab = lab;
    }
    return _titleLab;
}

-(CNVIdeoImageView *)iconImageView{
    if (!_iconImageView) {
        CNVIdeoImageView *imageView = [[CNVIdeoImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.backgroundColor = EDTRGBColor(234,237,240);
        WeakSelf(weakSelf);
        imageView.videoTableCellVideoDidBeginPlayHandle = ^(UIButton *playBtn){
            //播放／暂停
            if ([weakSelf.delegate respondsToSelector:@selector(videoTableViewCell:didClickPlayBtnWithVideoUrl:videoCover:)]) {
                [weakSelf.delegate videoTableViewCell:weakSelf didClickPlayBtnWithVideoUrl:self.videoUrl videoCover:self.iconImageView];
            }
        };
        [self.bgView addSubview:imageView];
        _iconImageView = imageView;
    }
    
    return _iconImageView;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = [UIColor lightGrayColor];
        lab.font = kFont(13);
        lab.textAlignment = NSTextAlignmentRight;
        [self.bgView addSubview:lab];
        _timeLab = lab;
    }
    
    return _timeLab;
}

-(UILabel *)desLab{
    if (!_desLab) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = kFont(13);
        lab.numberOfLines = 0;
        lab.textColor = [UIColor lightGrayColor];
        [self.bgView addSubview:lab];
        _desLab = lab;
    }
    return _desLab;
}

-(UIView *)bgView{
    if (!_bgView) {
        UIView * view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-10);
        }];
        
        _bgView = view;
    }
    return _bgView;
}

@end
