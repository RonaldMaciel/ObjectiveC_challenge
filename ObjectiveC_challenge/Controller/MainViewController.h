//
//  MainViewController.h
//  ObjectiveC_challenge
//
//  Created by Ronald Maciel on 17/03/20.
//  Copyright © 2020 Matheus Lima Ferreira. All rights reserved.
//

#import "ViewController.h"
#import "DetailsViewController.h"
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface MainViewController: UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


-(void) fetchMovies;
-(void) fetchMoreNowPlayingMovies;

@end

NS_ASSUME_NONNULL_END
