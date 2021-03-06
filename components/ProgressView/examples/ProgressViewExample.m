/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

#import "MaterialPalettes.h"
#import "MaterialProgressView.h"
#import "MaterialTypography.h"

static const CGFloat MDCProgressViewAnimationDuration = 1.f;

@interface ProgressViewExample : UIViewController

@property(nonatomic, strong) MDCProgressView *stockProgressView;
@property(nonatomic, strong) UILabel *stockProgressLabel;

@property(nonatomic, strong) MDCProgressView *tintedProgressView;
@property(nonatomic, strong) UILabel *tintedProgressLabel;

@property(nonatomic, strong) MDCProgressView *fullyColoredProgressView;
@property(nonatomic, strong) UILabel *fullyColoredProgressLabel;

@property(nonatomic, strong) MDCProgressView *backwardProgressView;
@property(nonatomic, strong) UILabel *backwardProgressLabel;

@end

@implementation ProgressViewExample

- (void)setupProgressViews {
  _stockProgressView = [[MDCProgressView alloc] init];
  _stockProgressView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_stockProgressView];
  // Hide the progress view at setup time.
  _stockProgressView.hidden = YES;

  _tintedProgressView = [[MDCProgressView alloc] init];
  _tintedProgressView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_tintedProgressView];
  _tintedProgressView.progressTintColor = [[MDCPalette redPalette] tint500];
  // Reset the track tint color to be based off of the progress tint color.
  _tintedProgressView.trackTintColor = nil;
  // Hide the progress view at setup time.
  _tintedProgressView.hidden = YES;

  _fullyColoredProgressView = [[MDCProgressView alloc] init];
  _fullyColoredProgressView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_fullyColoredProgressView];
  _fullyColoredProgressView.progressTintColor = [[MDCPalette greenPalette] tint500];
  _fullyColoredProgressView.trackTintColor = [[MDCPalette yellowPalette] tint500];
  // Hide the progress view at setup time.
  _fullyColoredProgressView.hidden = YES;

  _backwardProgressView = [[MDCProgressView alloc] init];
  _backwardProgressView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_backwardProgressView];
  // Have a non-zero progress at setup time.
  _backwardProgressView.progress = 0.33;
}

@end

@implementation ProgressViewExample (Supplemental)

- (void)dealloc {
  [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Progress View";
  self.view.backgroundColor = [UIColor whiteColor];

  [self setupProgressViews];
  [self setupLabels];
  [self setupConstraints];
}

- (void)setupLabels {
  _stockProgressLabel = [[UILabel alloc] init];
  _stockProgressLabel.text = @"Progress";
  _stockProgressLabel.font = [MDCTypography captionFont];
  _stockProgressLabel.alpha = [MDCTypography captionFontOpacity];
  _stockProgressLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_stockProgressLabel];

  _tintedProgressLabel = [[UILabel alloc] init];
  _tintedProgressLabel.text = @"Progress with progress tint";
  _tintedProgressLabel.font = [MDCTypography captionFont];
  _tintedProgressLabel.alpha = [MDCTypography captionFontOpacity];
  _tintedProgressLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_tintedProgressLabel];

  _fullyColoredProgressLabel = [[UILabel alloc] init];
  _fullyColoredProgressLabel.text = @"Progress with custom colors";
  _fullyColoredProgressLabel.font = [MDCTypography captionFont];
  _fullyColoredProgressLabel.alpha = [MDCTypography captionFontOpacity];
  _fullyColoredProgressLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_fullyColoredProgressLabel];

  _backwardProgressLabel = [[UILabel alloc] init];
  _backwardProgressLabel.text = @"Backward progress";
  _backwardProgressLabel.font = [MDCTypography captionFont];
  _backwardProgressLabel.alpha = [MDCTypography captionFontOpacity];
  _backwardProgressLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_backwardProgressLabel];
}

- (void)setupConstraints {
  NSDictionary *views = @{
    @"stockView" : _stockProgressView,
    @"stockLabel" : _stockProgressLabel,
    @"tintedView" : _tintedProgressView,
    @"tintedLabel" : _tintedProgressLabel,
    @"coloredView" : _fullyColoredProgressView,
    @"coloredLabel" : _fullyColoredProgressLabel,
    @"backwardView" : _backwardProgressView,
    @"backwardLabel" : _backwardProgressLabel,
  };
  NSDictionary *metrics = @{
    @"p" : @20,
    @"s" : @40,
    @"h" : @2,
  };

  NSArray *verticalConstraints =
      [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(p)-"
                                                       "[stockView(==h)]-(p)-[stockLabel]-(s)-"
                                                       "[tintedView(==h)]-(p)-[tintedLabel]-(s)-"
                                                       "[coloredView(==h)]-(p)-[coloredLabel]-(s)-"
                                                       "[backwardView(==h)]-(p)-[backwardLabel]"
                                              options:0
                                              metrics:metrics
                                                views:views];
  [self.view addConstraints:verticalConstraints];

  NSMutableArray *horizontalConstraints = [NSMutableArray array];
  NSArray *horizontalVisualFormats = @[
    @"H:|-(p)-[stockView]-(p)-|",
    @"H:|-(p)-[tintedView]-(p)-|",
    @"H:|-(p)-[coloredView]-(p)-|",
    @"H:|-(p)-[backwardView]-(p)-|",
    @"H:|-(>=p)-[stockLabel]-(>=p)-|",
    @"H:|-(>=p)-[tintedLabel]-(>=p)-|",
    @"H:|-(>=p)-[coloredLabel]-(>=p)-|",
    @"H:|-(>=p)-[backwardLabel]-(>=p)-|",
  ];
  for (NSString *format in horizontalVisualFormats) {
    [horizontalConstraints
        addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:format
                                                                    options:0
                                                                    metrics:metrics
                                                                      views:views]];
  }
  [self.view addConstraints:horizontalConstraints];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self animateStep1:_stockProgressView];
  [self animateStep1:_tintedProgressView];
  [self animateStep1:_fullyColoredProgressView];
  [self animateBackwardProgressView];
}

- (void)animateStep1:(MDCProgressView *)progressView {
  progressView.progress = 0;
  __weak MDCProgressView *weakProgressView = progressView;
  [progressView setHidden:NO
                 animated:YES
               completion:^(BOOL finished) {
                 [self performSelector:@selector(animateStep2:)
                            withObject:weakProgressView
                            afterDelay:MDCProgressViewAnimationDuration];
               }];
}

- (void)animateStep2:(MDCProgressView *)progressView {
  [progressView setProgress:0.5 animated:YES completion:nil];
  [self performSelector:@selector(animateStep3:)
             withObject:progressView
             afterDelay:MDCProgressViewAnimationDuration];
}

- (void)animateStep3:(MDCProgressView *)progressView {
  [progressView setProgress:1 animated:YES completion:nil];
  [self performSelector:@selector(animateStep4:)
             withObject:progressView
             afterDelay:MDCProgressViewAnimationDuration];
}

- (void)animateStep4:(MDCProgressView *)progressView {
  __weak MDCProgressView *weakProgressView = progressView;
  [progressView setHidden:YES
                 animated:YES
               completion:^(BOOL finished) {
                 [self performSelector:@selector(animateStep1:)
                            withObject:weakProgressView
                            afterDelay:MDCProgressViewAnimationDuration];
               }];
}

- (void)animateBackwardProgressView {
  __weak ProgressViewExample *weakSelf = self;
  [_backwardProgressView setProgress:1 - _backwardProgressView.progress
                            animated:YES
                          completion:^(BOOL finished) {
                            [weakSelf performSelector:@selector(animateBackwardProgressView)
                                           withObject:nil
                                           afterDelay:MDCProgressViewAnimationDuration];
                          }];
}

#pragma mark - Catalog by Convention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Progress View", @"Progress View" ];
}

+ (NSString *)catalogDescription {
  return @"Progress View is a visual indication of an app loading content. It can display how "
         @"long an operation will take.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end
