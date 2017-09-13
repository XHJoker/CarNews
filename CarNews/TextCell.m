//
//  TextCell.m
//  CarNews
//
//  Created by SiYugui on 2017/8/24.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "TextCell.h"
#import <Masonry.h>

@interface TextCell()
@property (nonatomic,strong) UILabel *wordLab;
@property (nonatomic,strong) UIView *bgView;
@end

@implementation TextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellFrame:(TextCellFrame *)frame{
    self.wordLab.frame = frame.textLableF;
    self.wordLab.text = frame.word;
    self.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
}

-(UILabel *)wordLab{
    if (!_wordLab) {
        _wordLab = [[UILabel alloc] init];
        _wordLab.font = [UIFont systemFontOfSize:16];
        _wordLab.numberOfLines = 0;
        [self.bgView addSubview:_wordLab];
    }
    
    return _wordLab;
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-10);
        }];
        
    }
    return _bgView;
}

@end
