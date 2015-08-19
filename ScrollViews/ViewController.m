//
//  ViewController.m
//  ScrollViews
//
//  Created by dmi on 18/08/15.
//  Copyright (c) 2015 dmi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong)UIImageView *imageView;

-(void)centerScrollViewContents;
-(void)scrollViewDoubleTapped:(UITapGestureRecognizer *)recognizer;
-(void)scrollViewTwoFingerTapped:(UITapGestureRecognizer *)recognizer;

@end

@implementation ViewController

@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;

-(void)centerScrollViewContents
{


    CGSize boundSize = self.scrollView.bounds.size;
    CGRect contentsFrame =self.imageView.frame;
    
    if(contentsFrame.size.width < boundSize.width)
    {
    
        contentsFrame.origin.x = (boundSize.width - contentsFrame.size.width)/2.0f;
    
    }
    else
    {
        contentsFrame.origin.x=0.0f;
    }

    if (contentsFrame.size.height < boundSize.height) {
        contentsFrame.origin.y = (boundSize.height - contentsFrame.size.height)/2.0f;
    }
    else
    {
        contentsFrame.origin.y = 0.0f;
    
    }
    
    self.imageView.frame = contentsFrame;
}


-(void)scrollViewDoubleTapped:(UITapGestureRecognizer *)recognizer
{


    CGPoint pointInView = [recognizer locationInView:self.imageView];
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    CGSize scrollViewSize = self.scrollView.bounds.size;
    CGFloat w = scrollViewSize.width/newZoomScale;
    CGFloat h = scrollViewSize.height/newZoomScale;
    CGFloat x = pointInView.x  - (w/2.0f);
    CGFloat y = pointInView.y - (h/2.0f);
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];

}

-(UIView *)viewForZoomingInScrollView : (UIScrollView *)scrollView
{
    return self.imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centerScrollViewContents];

}

-(void)scrollViewTwoFingerTapped:(UITapGestureRecognizer *)recognizer
{

// Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale/1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *image = [UIImage imageNamed:@"photo1.png"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame = (CGRect) {.origin=CGPointMake(0.0f, 0.0f), .size=image.size};
    [self.scrollView addSubview:self.imageView];
    
    self.scrollView.contentSize = image.size;
    
    UITapGestureRecognizer *doubleTapRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecogniser.numberOfTapsRequired=2;
    doubleTapRecogniser.numberOfTouchesRequired=1;
    [self.scrollView addGestureRecognizer:doubleTapRecogniser];
    
    
    
    
    UITapGestureRecognizer *twoFingerTapRecogniser = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecogniser.numberOfTouchesRequired=2;
    twoFingerTapRecogniser.numberOfTapsRequired=1;
    [self.scrollView addGestureRecognizer:twoFingerTapRecogniser];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width;
    CGFloat scaleHeight = scrollViewFrame.size.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    self.scrollView.minimumZoomScale=minScale;
    
    
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = minScale;

    [self centerScrollViewContents];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
