//
//  RequestManager.m
//  PremierEstate
//
//  Created by Dragos on 24/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#import "RequestManager.h"
#import "Residence.h"
#import "Listing.h"
#import "ImageURL.h"
#import "City.h"
#import "District.h"
#import "Utils.h"


@implementation RequestManager


+(RequestManager*)sharedManager
{
    static RequestManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[RequestManager alloc] init];
    });
    
    return sharedMyManager;
}


- (void)getPortfolio:(void (^)(id result, NSError *error))block {

    NSURL *url = [NSURL URLWithString:URLportfolio];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSMutableArray* residences = [[NSMutableArray alloc]init];
        
         NSError *error;
         NSArray *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         //NSLog(@"%@",json);
         for (NSDictionary* dict in json) {
             Residence *r = [[Residence alloc]init];
             
             r.iD = [[dict valueForKey:@"id"] stringValue];
             r.name = [dict valueForKey:@"name"];
             r.price = [dict valueForKey:@"type_price"];
             r.imageURL = [[dict valueForKey:@"type_image_path"] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
             
             r.purpose = [dict valueForKey:@"type_purpose"];
             r.descr = [dict valueForKey:@"type_description"];
             r.shortDescr = [dict valueForKey:@"type_short_description"];
             
             r.latitude = [[dict valueForKey:@"type_lat"] doubleValue];
             r.longitude = [[dict valueForKey:@"type_lng"] doubleValue];
             
             r.features = [NSMutableArray new];
             
             [r.features addObject:[dict valueForKey:@"type_ft1"]];
             [r.features addObject:[dict valueForKey:@"type_ft2"]];
             [r.features addObject:[dict valueForKey:@"type_ft3"]];
             [r.features addObject:[dict valueForKey:@"type_ft4"]];
             
             
             [residences addObject:r];
         }
         block(residences,nil);

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil,error);


    }];
    
    [operation start];
    
}


- (void)getListings:(void (^)(id result, NSError *error))block {
    
    NSURL *url = [NSURL URLWithString:URLestates];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSMutableArray* listings = [[NSMutableArray alloc]init];
         
         NSError *error;
         NSArray *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"%@",json);
                  for (NSDictionary* dict in json) {
         
                      Listing* l = [self parseInfoFromDict:dict];

                      [listings addObject:l];
                  }
                  block(listings,nil);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         block(nil,error);
         
     }];
    
    [operation start];
    
}


- (void)getListingsWithQueryURL:(NSString*)queryURL  result:(void (^)(id result, NSError *error))block {
    
    NSURL *url = [NSURL URLWithString:queryURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSMutableArray* listings = [[NSMutableArray alloc]init];
         
         NSError *error;
         NSArray *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"%@",json);
         
         
         if ([json isKindOfClass:[NSDictionary class]]) {
             if ([[[json valueForKey:@"empty"] stringValue] isEqualToString:@"1"]) {
                 block(listings,nil);
                 return;
             }
         }
         
         for (NSDictionary* dict in json) {
             
             Listing* l = [self parseInfoFromDict:dict];
             
             [listings addObject:l];
         }
         block(listings,nil);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         block(nil,error);
         
     }];
    
    [operation start];
    
}




- (void)getListingsForLat:(NSString*)lat lng:(NSString*)lng andRadius:(NSString*)radius result:(void (^)(id result, NSError *error))block
{
    NSString* strURL = [NSString stringWithFormat:@"%@%@%@%@%@%@",URLradius,lat,@"&lng=",lng,@"&radius=",radius];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSMutableArray* listings = [[NSMutableArray alloc]init];
         
         NSError *error;
         NSArray *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"%@",json);
         
         
        // no listings in radius
         if ([json isKindOfClass:[NSDictionary class]]) {
             if ([[[json valueForKey:@"ok"] stringValue] isEqualToString:@"0"]) {
                 block(listings,nil);
                 return;
             }
         }
                  
         for (NSDictionary* dict in json) {

             Listing* l = [self parseInfoFromDict:dict];

             [listings addObject:l];
         }
         
         block(listings,nil);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         block(nil,error);
         
     }];
    
    [operation start];
}




- (void)getImagesURLForEstateID:(NSString*)iD result:(void (^)(id result, NSError *error))block {
    
    NSURL *url = [NSURL URLWithString:[URLimages stringByAppendingString:iD]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSMutableArray* paths = [[NSMutableArray alloc]init];
         
         NSError *error;
         NSArray *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"%@",json);
         for (NSDictionary* dict in json) {
             ImageURL* imgURL = [[ImageURL alloc]init];
             
             imgURL.pathThumb = [[dict valueForKey:@"thumb_path"] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
             imgURL.pathFullImage = [[dict valueForKey:@"path"] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
             
             [paths addObject:imgURL];
         }
         block(paths,nil);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         block(nil,error);
         
     }];
    
    [operation start];
    
}


- (void)getListingsForEstateID:(NSString*)estateId result:(void (^)(id result, NSError *error))block {
    
    NSURL *url = [NSURL URLWithString:[URLestatesID stringByAppendingString:estateId]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSMutableArray* listings = [[NSMutableArray alloc]init];
         
         NSError *error;
         NSArray *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"%@",json);
         
         if ([json isKindOfClass:[NSDictionary class]]) {
             if ([[[json valueForKey:@"empty"] stringValue] isEqualToString:@"1"]) {
                 block(listings,nil);
                 return;
             }
         }
         
         for (NSDictionary* dict in json) {
             
             Listing* l = [self parseInfoFromDict:dict];
             
             [listings addObject:l];
         }
         block(listings,nil);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         block(nil,error);
         
     }];
    
    [operation start];
    
}


- (void)getCities:(void (^)(id result, NSError *error))block {
    
    NSURL *url = [NSURL URLWithString:URLcities];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSMutableArray* cities = [[NSMutableArray alloc]init];
         
         NSError *error;
         NSArray *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"%@",json);
         for (NSDictionary* dict in json) {
             
             City* city = [[City alloc]init];
             city.name = [dict valueForKey:@"name"];
             city.ID = [dict valueForKey:@"id"];
             
             [cities addObject:city];
         }
         
         block(cities,nil);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         block(nil,error);
         
     }];
    
    [operation start];
    
}


- (void)getDistricts:(void (^)(id result, NSError *error))block {
    
    NSURL *url = [NSURL URLWithString:URLcounties];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSMutableArray* cities = [[NSMutableArray alloc]init];
         
         NSError *error;
         NSArray *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"%@",json);
         for (NSDictionary* dict in json) {
             
             District* d = [[District alloc]init];
             d.name = [dict valueForKey:@"name"];
             d.ID = [dict valueForKey:@"id"];
             
             [cities addObject:d];
             
             if (cities.count == 7) {  // remove Ilfov :)) 
                 break;
             }
         }
         block(cities,nil);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         block(nil,error);
         
     }];
    
    [operation start];
    
}



// listing parser
-(Listing*)parseInfoFromDict:(NSDictionary*)dict
{
    Listing* l = [[Listing alloc]init];
    
    l.iD = [[dict valueForKey:@"id"] stringValue];
    l.title = [dict valueForKey:@"title"];
    l.price = [[dict valueForKey:@"price"] stringValue];
    l.imageURL = [[dict valueForKey:@"image_path"] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    l.portfolio = [dict valueForKey:@"type_name"];
    l.address = [dict valueForKey:@"address"];
    l.roomsNo = [[dict valueForKey:@"bedrooms"] stringValue];
    l.area = [[dict valueForKey:@"area"] stringValue];
    //
    l.year_built = [[dict valueForKey:@"estates_year_built"] stringValue];
    l.city = [dict valueForKey:@"county_name"];
    l.district = [dict valueForKey:@"cities_name"];
    l.areaBuilt = [[dict valueForKey:@"estates_built_area"] stringValue];
    l.bathroomsNo = [[dict valueForKey:@"bathrooms"] stringValue];
    l.floor = [[dict valueForKey:@"estates_floors"] stringValue];
    l.parkingsNo = [[dict valueForKey:@"estates_parking"] stringValue];
    l.latitude = [[dict valueForKey:@"type_lat"] doubleValue];
    l.longitude = [[dict valueForKey:@"type_lng"] doubleValue];
    l.descr = [dict valueForKey:@"description"];
    l.content = [dict valueForKey:@"content"];
    
    l.content = [Utils removeString:@"<p>" fromString:l.content];
    l.content = [Utils removeString:@"</p>" fromString:l.content];
    
    
    return l;
}





@end
