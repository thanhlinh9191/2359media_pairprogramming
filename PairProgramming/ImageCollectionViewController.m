//
//  ImageCollectionViewController.m
//  PairProgramming
//
//  Created by ThanhLinh on 2/26/14.
//  Copyright (c) 2014 ThanhLinh. All rights reserved.
//

#import "ImageCollectionViewController.h"
#import  <PXAPI.h>
@interface ImageCollectionViewController ()

@end

@implementation ImageCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.imagesArray =[[NSMutableArray alloc] init];
    
    NSString *consumerKey =@"9eddEMUbRMMl3cLQ3BcQcOUBD02m8D7YiC3uGdWa";
    NSString *consumerSecret=@"lu1ekhlzWQf8PBwHBmRHitnQrWUSfDbGq94t5pgp";
    
    [PXRequest setConsumerKey:consumerKey consumerSecret:consumerSecret];
    [PXRequest requestForPhotoFeature:PXAPIHelperPhotoFeaturePopular completion:^(NSDictionary *results, NSError *error) {
        if (error)
        {
            [[[UIAlertView alloc] initWithTitle:@"Couldn't fetch from 500px." message:error.localizedDescription delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
            return;
        }
        
        NSArray *photosArray = [results valueForKey:@"photos"];
        for (NSDictionary *photoDict in photosArray)
        {
            NSString *urlString = [[[photoDict valueForKey:@"images"] objectAtIndex:0] valueForKey:@"url"];
            NSLog(@"url la %@", urlString);
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
            UIImage *image = [UIImage imageWithData:imageData];
            [ self.imagesArray addObject:image];
            
            //lay 30 cai demo cho no nhanh
            
            if(self.imagesArray.count==30){
                break;
            }
        }
        NSLog(@"da lay xong roi");
        [self.collectionView reloadData];
    
    }];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagesArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    NSString *cellIdentifier = @"Cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    UIImageView *imageView = (UIImageView*) [cell viewWithTag:100];
    
    
    imageView.image = [self.imagesArray objectAtIndex:indexPath.row];
    
    return cell;
    
}
@end









