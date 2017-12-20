//
//  LflSlider.h
//  LflVideo
//
//  Created by Yomoo on 2017/12/20.
//  Copyright © 2017年 Yomoo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LflSlider;

typedef void (^SliderValueChangeBlock) (LflSlider *slider);
typedef void (^SliderFinishChangeBlock) (LflSlider *slider);
typedef void (^DraggingSliderBlock) (LflSlider *slider);
@interface LflSlider : UIView
@property (nonatomic, assign) CGFloat value;        /* From 0 to 1 */
@property (nonatomic, assign) CGFloat middleValue;  /* From 0 to 1 */

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat sliderDiameter;
@property (nonatomic, strong) UIColor *sliderColor;
@property (nonatomic, strong) UIColor *maxColor;
@property (nonatomic, strong) UIColor *middleColor;
@property (nonatomic, strong) UIColor *minColor;

@property (nonatomic, copy) SliderValueChangeBlock valueChangeBlock;
@property (nonatomic, copy) SliderFinishChangeBlock finishChangeBlock;
@property (nonatomic, strong) DraggingSliderBlock draggingSliderBlock;
@end
