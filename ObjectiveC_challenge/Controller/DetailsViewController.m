//
//  DetailsViewController.m
//  ObjectiveC_challenge
//
//  Created by Matheus Lima Ferreira on 3/16/20.
//  Copyright © 2020 Matheus Lima Ferreira. All rights reserved.
//

#import "DetailsViewController.h"
#import <UIKit/UIKit.h>
#import "Network.h"
@interface DetailsViewController () {
    Network *network;
}

@end

@implementation DetailsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    network = [[Network alloc] init];
    [self setupPosterImageView];
    [self configureWithMovie:self.movie];
}

- (void)viewWillAppear:(BOOL)animated {
    self.title = @"Movie Details";
    self.navigationController.navigationBar.prefersLargeTitles = NO;
}

- (void) setupPosterImageView {
    self.posterImageView.layer.cornerRadius = 10;
    self.posterImageView.clipsToBounds = YES;
}


- (void) configureWithMovie: (Movie *)movieDetail {
    self.titleMovie.text = movieDetail.title;
    self.overviewTextView.text = movieDetail.overview;
    self.ratingLabel.text = movieDetail.rating.stringValue;
    self.imageURL = movieDetail.imageUrl;
    
    /// Loads cover
    NSMutableString *baseImageUrl = [NSMutableString stringWithString:@"https://image.tmdb.org/t/p/w185"];
    NSString *imageURL = [baseImageUrl stringByAppendingString:self.imageURL];
    
    NSLog(@"Will load image from url: %@", imageURL);
    
    NSMutableArray<NSString*> *genrerList = NSMutableArray.new;
    
    NSMutableString* concatGenres = NSMutableString.new;
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageURL]];
        
        if ( data == nil ) return;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage *image = [UIImage imageWithData:data];
            self.posterImageView.image = image;
            
        });
        
        
    });
    [self->network fetchMovieDetails:movieDetail.movieID completion:^(Movie * movieDetails) {
        
        for (NSString *genre in movieDetails.genrerList) {
            
            [concatGenres appendFormat:@"%@, ", genre];
        }  
    }];
    


    dispatch_async(dispatch_get_main_queue(), ^{
        self.genderListLabel.text = concatGenres;
    });
    
    
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
