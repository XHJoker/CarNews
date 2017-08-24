//
//  CircleScrollView.m
//  TestB
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 xincheng. All rights reserved.
//

#import "CircleScrollView.h"
#import "ImageContentView.h"

@interface CircleScrollView()

@property(nonatomic,retain)NSArray *imgArr;
@property(nonatomic,retain)UIPageControl *pageControl;
@property(nonatomic,retain)UIScrollView *scrollView;

@property(nonatomic,retain)NSTimer *timer;
@end

@implementation CircleScrollView

-(instancetype)initWithImgUrls:(NSArray *)urlStrArr fram:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.circleScrollType = CircleScrollTypeDefault;
        self.circleScrollStyle = CircleScrollStyleNone;

        self.frame = frame;
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.imgArr = urlStrArr;
        __weak typeof(self)weakSelf = self;
        ImageContentView *contentView = [[ImageContentView alloc]initWithContentFrame:CGRectMake(0,0,frame.size.width,frame.size.height) andimgUrlStr:[urlStrArr lastObject] andBtnBlock:^(void) {
            
            if (weakSelf.scrollView.delegate&&[weakSelf.circleDelegate respondsToSelector:@selector(circleScroll:selectIndex:)]) {
                [weakSelf.circleDelegate circleScroll:weakSelf selectIndex:urlStrArr.count -1];
            }
            
        }];
        contentView.tag = urlStrArr.count ;
        [self.scrollView addSubview:contentView];
        
        if (urlStrArr.count == 1) {
            self.scrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
        }else
        {
            self.scrollView.contentSize = CGSizeMake(frame.size.width*(urlStrArr.count+2), frame.size.height);
            self.scrollView.contentOffset = CGPointMake(frame.size.width, 0);
            
            for (int i = 0; i<urlStrArr.count; i++) {
                
                ImageContentView *contentView = [[ImageContentView alloc]initWithContentFrame:CGRectMake(frame.size.width*(i+1),0,frame.size.width,frame.size.height) andimgUrlStr:urlStrArr [i] andBtnBlock:^(void) {
                    
                    if (weakSelf.scrollView.delegate&&[weakSelf.circleDelegate respondsToSelector:@selector(circleScroll:selectIndex:)]) {
                        [weakSelf.circleDelegate circleScroll:weakSelf selectIndex:i];
                    }
                    
                }];
                contentView.tag = i;
                [self.scrollView addSubview:contentView];
                
            }
            
            __weak typeof(self)weakSelf = self;
            ImageContentView *contentView1 = [[ImageContentView alloc]initWithContentFrame:CGRectMake(frame.size.width * (urlStrArr.count+1),0,frame.size.width,frame.size.height) andimgUrlStr:[urlStrArr firstObject] andBtnBlock:^(void) {
                
                if (weakSelf.scrollView.delegate&&[weakSelf.circleDelegate respondsToSelector:@selector(circleScroll:selectIndex:)]) {
                    [weakSelf.circleDelegate circleScroll:weakSelf selectIndex:0];
                }
                
            }];
            contentView1.tag = 0 ;
            [self.scrollView addSubview:contentView1];
            
        }
        
    }
    return self;
}
-(instancetype)initWithImgs:(NSArray *)StrArr fram:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.circleScrollType = CircleScrollTypeDefault;
        self.circleScrollStyle = CircleScrollStyleNone;
        self.frame = frame;
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.imgArr = StrArr;
        
        
        /*
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        btn.layer.contents = (id)[UIImage imageNamed:[StrArr lastObject]].CGImage;
        btn.tag = StrArr.count - 1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        */
        
        __weak typeof(self)weakSelf = self;
        ImageContentView *contentView = [[ImageContentView alloc]initWithContentFrame:CGRectMake(0,0,frame.size.width,frame.size.height) andimgStr:[StrArr lastObject] andBtnBlock:^(void) {
            
            if (weakSelf.scrollView.delegate&&[weakSelf.circleDelegate respondsToSelector:@selector(circleScroll:selectIndex:)]) {
                [weakSelf.circleDelegate circleScroll:weakSelf selectIndex:StrArr.count -1];
            }
            
        }];
        contentView.tag = StrArr.count ;
        [self.scrollView addSubview:contentView];
        
        
        
        
        if (StrArr.count == 1) {
        self.scrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
        }else
        {
            self.scrollView.contentSize = CGSizeMake(frame.size.width*(StrArr.count+2), frame.size.height);
            self.scrollView.contentOffset = CGPointMake(frame.size.width, 0);
            
            for (int i = 0; i<StrArr.count; i++) {
               
                
                /*
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width*(i+1),0,frame.size.width,frame.size.height)];
                btn.tag = i;
                  btn.layer.contents = (id)[UIImage imageNamed:StrArr [i]].CGImage;
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

                [self.scrollView addSubview:btn];
                */
                
                ImageContentView *contentView = [[ImageContentView alloc]initWithContentFrame:CGRectMake(frame.size.width*(i+1),0,frame.size.width,frame.size.height) andimgStr:StrArr [i] andBtnBlock:^(void) {
                    
                    if (weakSelf.scrollView.delegate&&[weakSelf.circleDelegate respondsToSelector:@selector(circleScroll:selectIndex:)]) {
                        [weakSelf.circleDelegate circleScroll:weakSelf selectIndex:i];
                    }
                    
                }];
                contentView.tag = i;
                [self.scrollView addSubview:contentView];
                
            }
            
            /*
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width * (StrArr.count+1),0,frame.size.width,frame.size.height)];
              btn.layer.contents = (id)[UIImage imageNamed:[StrArr firstObject]].CGImage;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 0 ;
            [self.scrollView addSubview:btn];
            */
            
            
            __weak typeof(self)weakSelf = self;
            ImageContentView *contentView1 = [[ImageContentView alloc]initWithContentFrame:CGRectMake(frame.size.width * (StrArr.count+1),0,frame.size.width,frame.size.height) andimgStr:[StrArr firstObject] andBtnBlock:^(void) {
                
                if (weakSelf.scrollView.delegate&&[weakSelf.circleDelegate respondsToSelector:@selector(circleScroll:selectIndex:)]) {
                    [weakSelf.circleDelegate circleScroll:weakSelf selectIndex:0];
                }
                
            }];
            contentView1.tag = 0 ;
            [self.scrollView addSubview:contentView1];
            
        }

    }
    return self;
}


//
//-(void)btnClick:(UIButton *)sender
//{
//   
//    /*
//    if (self.scrollView.delegate&&[self.circleDelegate respondsToSelector:@selector(circleScroll:selectIndex:)]) {
//        [self.circleDelegate circleScroll:self selectIndex:sender.tag];
//    }
//     
//     */
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (scrollView.contentOffset.x >= (self.imgArr.count+1)*scrollView.frame.size.width) {
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0)];
        
        
    }else if (scrollView.contentOffset.x <= 0)
    {
        
        [scrollView setContentOffset:CGPointMake(self.imgArr.count*scrollView.frame.size.width, 0)];

    }
    
    if (_circleScrollType != CircleScrollTypeDefault) {
        
        CGFloat pag = scrollView.contentOffset.x/scrollView.frame.size.width;
        int num = (pag-(int)pag) >0.5?(int)pag + 1:(int)pag;
        _pageControl.currentPage = num%self.imgArr.count == 0?self.imgArr.count-1:(num%self.imgArr.count)-1;
        
    }
    
    for (ImageContentView *subView in scrollView.subviews) {
        
        if ([subView respondsToSelector:@selector(imageOffsetValue:)] ) {
           
            if (self.circleScrollStyle == CircleScrollStyleSteadfast) {
                [subView imageOffsetValue:1];
            }else if(self.circleScrollStyle == CircleScrollStyleSkewing)
            {
                [subView imageOffsetValue:0.7];

            }
        }
    }    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [_timer setFireDate:[NSDate distantFuture]];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  
    [self performSelector:@selector(timerFire) withObject:nil afterDelay:3];
}

-(void)timerFire
{
    [_timer setFireDate:[NSDate date]];
}

-(void)setCircleScrollType:(CircleScrollType)circleScrollType
{
    _circleScrollType = circleScrollType;
    
    if (_circleScrollType != CircleScrollTypeDefault) {
        self.pageControl.numberOfPages = self.imgArr.count;
        
        if (_circleScrollType == CircleScrollTypePageControlAndTimer)
        {
            _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
            [_timer fire];
        }
    }
}

-(void)timerAction:(id)timer
{

    [_scrollView setContentOffset:CGPointMake((_pageControl.currentPage+2)*_scrollView.frame.size.width,0) animated:YES];
    
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,self.frame.size.height-20, self.frame.size.width,10)];
        [_pageControl setPageIndicatorTintColor:[UIColor colorWithRed:226/255.0f green:226/255.0f blue:226/255.0f alpha:1.0]];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:255/255.0f green:115/255.0f blue:5/255.0f alpha:1.0]];
        [_pageControl setCurrentPage:0];
        [self addSubview:_pageControl];
    }
    return _pageControl;
}


-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
 
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
