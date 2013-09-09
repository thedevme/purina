//
//  BlogPostView.h
//  PurinaPetHealth
//
//  Created by Craig Clayton on 12/19/12.
//
//

#import <Foundation/Foundation.h>
#import "BlogData.h"


@interface BlogPostView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (strong, nonatomic) IBOutlet UITextView *txtDesc;

@property(nonatomic, strong) BlogData *objBlogData;

- (id)initWithBlogData:(BlogData *)data;

@end
