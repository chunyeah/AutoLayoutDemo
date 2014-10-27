//
//  CCInstagramMainViewController.m
//  CCAutoLayoutDemo
//
//  Created by Chun Ye on 10/27/14.
//  Copyright (c) 2014 Chun Tips. All rights reserved.
//

#import "CCInstagramMainViewController.h"

CGFloat const kLayoutPadding = 10.0f;

@interface CCInstagramMainViewController ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIImageView *photoImageView;

@property (nonatomic, copy) NSArray *constraits;

@end

@implementation CCInstagramMainViewController

#pragma mark - Life

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Instagram";
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.avatarImageView = [self createAvatarImageView];
    [self.view addSubview:self.avatarImageView];
    
    self.nameLabel = [self createNameLabel];
    [self.view addSubview:self.nameLabel];
    
    self.timeLabel = [self createTimeLabel];
    [self.view addSubview:self.timeLabel];
    
    self.descriptionLabel = [self createDescriptionLabel];
    [self.view addSubview:self.descriptionLabel];
    
    self.photoImageView = [self createPhotoImageView];
    [self.view addSubview:self.photoImageView];

    [self updateConstraintsForTraitCollection:self.traitCollection];
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    [self updateConstraintsForTraitCollection:newCollection];

    [coordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext> context) {
        [self updateConstraintsForTraitCollection:newCollection];
        [self.view setNeedsLayout];
    } completion:nil];
}

#pragma mark - Private

- (UIImageView *)createAvatarImageView
{
    UIImageView *avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar"]];
    avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
    return avatarImageView;
}

- (UILabel *)createNameLabel
{
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLabel.font = [UIFont systemFontOfSize:12.0f];
    nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    nameLabel.text = @"Chun Tips";
    return nameLabel;
}

- (UILabel *)createTimeLabel
{
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    timeLabel.font = [UIFont systemFontOfSize:11.0f];
    timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    timeLabel.text = @"2w ago";
    return timeLabel;
}

- (UILabel *)createDescriptionLabel
{
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    descriptionLabel.font = [UIFont systemFontOfSize:11.0f];
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    descriptionLabel.text = @"Apple, Google, Microsoft, Instagram, Twitter, Facebook and 4 others like this";
    descriptionLabel.numberOfLines = 0;
    return descriptionLabel;
}

- (UIImageView *)createPhotoImageView
{
    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    photoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    photoImageView.image = [UIImage imageNamed:@"photo"];
    return photoImageView;
}

- (void)updateConstraintsForTraitCollection:(UITraitCollection *)collection
{
    NSDictionary *views = @{@"topLayoutGuide": self.topLayoutGuide, @"avatarImageView": self.avatarImageView, @"nameLabel": self.nameLabel, @"timeLabel": self.timeLabel, @"descriptionLabel": self.descriptionLabel, @"photoImageView": self.photoImageView};
    NSDictionary *metrics = @{@"padding": @(kLayoutPadding)};
    NSMutableArray *updateConstraits = [NSMutableArray array];
    if (collection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        [updateConstraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[photoImageView]-(padding)-[avatarImageView]-(padding)-[nameLabel]" options:0 metrics:metrics views:views]];
        [updateConstraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[avatarImageView]-(padding)-[timeLabel]" options:0 metrics:metrics views:views]];
        [updateConstraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[photoImageView]-(padding)-[descriptionLabel]" options:0 metrics:metrics views:views]];
        [updateConstraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide][photoImageView]|" options:0 metrics:metrics views:views]];
        [updateConstraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-(padding)-[avatarImageView]-(padding)-[descriptionLabel]" options:0 metrics:metrics views:views]];
        [updateConstraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-(padding)-[nameLabel]-(padding)-[timeLabel]" options:0 metrics:metrics views:views]];
        self.descriptionLabel.preferredMaxLayoutWidth = self.view.bounds.size.width - self.view.bounds.size.height + self.topLayoutGuide.length - 2 * kLayoutPadding;
    } else {
        [updateConstraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(padding)-[avatarImageView]-(padding)-[nameLabel]" options:0 metrics:metrics views:views]];
        [updateConstraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[avatarImageView]-(padding)-[timeLabel]" options:0 metrics:metrics views:views]];
        [updateConstraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[photoImageView]|" options:0 metrics:nil views:views]];
        [updateConstraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(padding)-[descriptionLabel]" options:0 metrics:metrics views:views]];
        
        [updateConstraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-(padding)-[avatarImageView]-(padding)-[photoImageView]-(padding)-[descriptionLabel]" options:0 metrics:metrics views:views]];
        [updateConstraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-(padding)-[nameLabel]-(padding)-[timeLabel]" options:0 metrics:metrics views:views]];
        self.descriptionLabel.preferredMaxLayoutWidth = self.view.bounds.size.width - 2 * kLayoutPadding;
    }
    [updateConstraits addObject:[NSLayoutConstraint constraintWithItem:self.avatarImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.avatarImageView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [updateConstraits addObject:[NSLayoutConstraint constraintWithItem:self.photoImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.photoImageView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    
    if (self.constraits) {
        [NSLayoutConstraint deactivateConstraints:self.constraits];
    }
    
    self.constraits = updateConstraits;
    
    [NSLayoutConstraint activateConstraints:self.constraits];
}

@end
