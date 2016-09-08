//
//  Defines.h
//  PremierEstate
//
//  Created by Dragos on 24/09/15.
//  Copyright (c) 2015 SoftGalaxy. All rights reserved.
//

#ifndef PremierEstate_Defines_h
#define PremierEstate_Defines_h

#define appDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])


#define mainURL @"http://premier-estate.eu/mobileadmin/"

#define URLportfolio @"http://premier-estate.eu/mobileadmin/api/type_api/type"

#define URLproperty @"http://premier-estate.eu/mobileadmin/api/estate_api/estates?x=trick"

#define URLcities @"http://www.premier-estate.eu/mobileadmin/api/county_api/county" // get cities

#define URLcounties @"http://www.premier-estate.eu/mobileadmin/api/cities_api/cities" // get districts

#define URLestates @"http://premier-estate.eu/mobileadmin/api/estate_api/estates"

#define URLestatesID @"http://www.premier-estate.eu/mobileadmin/api/estate_api/estates?estate_id=" //the details for the listing

#define URLimages @"http://www.premier-estate.eu/mobileadmin/api/images_api/images/estate_id/" // just append the id

#define URLradius @"http://www.premier-estate.eu/mobileadmin/api/estate_api/nearby?lat="

////////////////////////////////////////////////////////////////////////////////////
#define portfolioDidLoad @"portfolioDidLoad"

#define TYPE_PURPOSE 1
#define TYPE_CITY 2
#define TYPE_DISTRICT 3 

#endif
