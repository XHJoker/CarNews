需要导入SDwebimage
//网络图片
CircleScrollView *scr = [[CircleScrollView alloc]initWithImgUrls:urlArr fram:CGRectMake(0,30, self.view.frame.size.width, 200)];
scr.circleScrollType = CircleScrollTypePageControlAndTimer;
scr.circleScrollStyle = CircleScrollStyleSteadfast;
scr.circleDelegate = self;
[self.view addSubview:scr];

/**
CircleScrollStyleNone,
图片始终固定在底部
CircleScrollStyleSteadfast,
scroll移动有一种视觉偏移误差
CircleScrollStyleSkewing

CircleScrollTypeDefault, //默认
CircleScrollTypePageControl, //带pageControl
CircleScrollTypePageControlAndTimer // 带pageControl和NSTimer
**/


CircleScrollDelegate

-(void)circleScroll:(CircleScrollView *)scrollView selectIndex:(NSInteger)index;