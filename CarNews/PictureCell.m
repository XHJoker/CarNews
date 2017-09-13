//
//  PictureCell.m
//  CarNews
//
//  Created by SiYugui on 2017/8/24.
//  Copyright © 2017年 SiYugui. All rights reserved.
//

#import "PictureCell.h"

#import "CNBaseImageView.h"
#import "CNGifImageView.h"
#import <Masonry.h>
#import "EdtMacro.h"

@interface PictureCell ()<UIActionSheetDelegate>

@property (nonatomic,weak) UIView *bgView;

@property (nonatomic, weak) UILabel *contentL;

@property (nonatomic ,weak) CNBaseImageView *iconImageView;

@property (nonatomic ,weak) CNGifImageView *gifImageView;
@end

@implementation PictureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellFrame:(PictureCellFrame *)frame{
    
    self.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
    
    [self removeAllImages];
    
    self.contentL.frame = frame.textLableF;
    self.contentL.text = frame.imageModel.text;
    if (frame.imageModel.type == NHHomeServiceDataElementMediaTypeLargeImage) {
        
        self.iconImageView.frame = frame.imageViewF;
        [self.iconImageView setImageWithUrl:frame.imageModel.url_list.firstObject placeHolder:nil];
    }
    else if (frame.imageModel.type == NHHomeServiceDataElementMediaTypeGif){
        
        self.gifImageView.frame = frame.imageViewF;
        
        [self.gifImageView setImageWithUrl:frame.imageModel.url_list.firstObject placeHolder:nil progressHandle:^(CGFloat progress) {
            self.gifImageView.progress = progress;
        } finishHandle:nil];
    }
}



- (void)removeAllImages {
    
    [_gifImageView removeFromSuperview];
    [_iconImageView removeFromSuperview];
    
    _gifImageView.image = nil;
    _iconImageView.image = nil;

    _gifImageView = nil;
    _iconImageView = nil;
    
}

- (void)longPassAction:(UILongPressGestureRecognizer *)longPress{
    
    //长按手势
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"保存图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存至相册", nil];
        sheet.delegate = self;
        [sheet showInView:self];
        
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
        if (self.iconImageView.image) {
            UIImageWriteToSavedPhotosAlbum(self.iconImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }
    }
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片:" message:msg delegate:nil cancelButtonTitle:@"确定"otherButtonTitles:nil];
    [alert show];
    
}

-(UILabel *)contentL{
    if (!_contentL) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont systemFontOfSize:16];
        lab.numberOfLines = 0;
        [self.bgView addSubview:lab];
        _contentL = lab;
    }
    
    return _contentL;
}

-(CNBaseImageView *)iconImageView{
    if (!_iconImageView) {
        CNBaseImageView *imageView = [[CNBaseImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.backgroundColor = EDTRGBColor(234,237,240);
        UIGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPassAction:)];
        [imageView addGestureRecognizer:gesture];
        [self.bgView addSubview:imageView];
        _iconImageView = imageView;
    }
    
    return _iconImageView;
}

-(CNGifImageView *)gifImageView{
    if (!_gifImageView) {
        CNGifImageView *gifView = [[CNGifImageView alloc] init];
        gifView.backgroundColor = EDTRGBColor(234,237,240);
        [self.bgView addSubview:gifView];
        _gifImageView = gifView;
    }
    
    return _gifImageView;
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
