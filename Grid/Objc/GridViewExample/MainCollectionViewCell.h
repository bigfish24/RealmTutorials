//
//  MainCollectionViewCell.h
//  GridViewExample
//
//  Created by Adam Fish on 10/27/15.
//  Copyright © 2015 Adam Fish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) IBOutlet UILabel *excerptLabel;

@end
