//
//  CircleScrollView.h
//  TestB
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 xincheng. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol CircleScrollDelegate;

typedef NS_ENUM(NSInteger,CircleScrollType) {
    CircleScrollTypeDefault, //默认
    CircleScrollTypePageControl, //带pageControl
    CircleScrollTypePageControlAndTimer // 带pageControl和NSTimer
};


typedef NS_ENUM(NSInteger,CircleScrollStyle){
    CircleScrollStyleNone,
    
    /**图片始终固定在底部*/
    CircleScrollStyleSteadfast,
    
    /**scroll移动有一种视觉偏移误差*/
    CircleScrollStyleSkewing

};



@interface CircleScrollView : UIView<UIScrollViewDelegate>

@property(nonatomic,assign)CircleScrollType circleScrollType;
@property(nonatomic,assign)CircleScrollStyle circleScrollStyle;

@property(nonatomic,assign)id <CircleScrollDelegate> circleDelegate;

-(instancetype)initWithImgUrls:(NSArray *)urlStrArr fram:(CGRect)frame;
-(instancetype)initWithImgs:(NSArray *)StrArr fram:(CGRect)frame;


@end

@protocol CircleScrollDelegate <NSObject>


//点击scrollview上的那个按钮.
-(void)circleScroll:(CircleScrollView *)scrollView selectIndex:(NSInteger)index;

//-(void)circleScrollViewDidScroll:(CircleScrollView *)scrollView;

@end

