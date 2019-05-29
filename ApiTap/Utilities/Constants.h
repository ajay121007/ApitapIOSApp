//
//  Constants.h
//
//

#ifndef Constants_h
#define Constants_h

#define BlueColor  [UIColor colorWithRed:16/255.00 green:124/255.00 blue:213/255.00 alpha:1];

#define LightGreyColor  [UIColor colorWithRed:234/255.00 green:234/255.00 blue:234/255.00 alpha:1];

#define DarkGreyColor  [UIColor colorWithRed:0/255.00 green:0/255.00 blue:0/255.00 alpha:1];

#define RedColor  [UIColor colorWithRed:212/255.00 green:11/255.00 blue:01/255.00 alpha:1];

#define GreenColor  [UIColor colorWithRed:58/255.00 green:137/255.00 blue:1/255.00 alpha:1];

#define OrangeColor  [UIColor colorWithRed:248/255.00 green:123/255.00 blue:1/255.00 alpha:1];

#define BlackBackground  [UIColor colorWithRed:39/255.00 green:39/255.00 blue:39/255.00 alpha:1];

#define Other  [UIColor colorWithRed:34/255.00 green:36/255.00 blue:85/255.00 alpha:1];
#define appBasicColor [UIColor(red: 48/256.0, green: 142/256.0, blue: 218/256.0, alpha: 1.0)];
//Request Path

// New QA
//
//#define kBaseUrlPath @"https://8.41.42.131:8095/NmcServerS/nmc-server/post/"
//#define kBaseUrlPath @"https://209.46.35.217:8081/NmcServerS/nmc-server/post/"

// New QA

//#define kBaseUrlPath @"https://209.46.35.217:8081/NmcServerS/nmc-server/post/"

#define kBaseUrlPath @"http://209.46.35.217:8020/NmcServerS/nmc-server/post/"

//QA

//#define kBaseUrlPath @"https://100.43.205.74:8095/NmcServerS/nmc-server/post/"

//Sunguard

//#define kBaseUrlPath @"https://66.179.57.58:8081/NmcServerS/nmc-server/post/"

//A0.#define kBaseUrlPathPayment @"https://100.43.205.74:4143/ServerApi/ApiService/"

#define kBaseUrl [NSURL URLWithString:kBaseUrlPath]

#define kRequestSignUp @"030300120"

#define kVerifyEmail @"050400009"

#define kGuestlogin @"010100517"

#define kRequestLogin @"050300010"

#define kRequestForForgetPassword @"020300279"

#define kAddAddressKey @"030400056"

#define kSearchItemsByOfferMobile @"010100478"

#define kSearchItemsByCategoryMobile @"010400478"

#define kSearchItemsSpecialsByCategoryMobile @"010400479"

//#define kSearchItemsSpecialsByCategoryMobile @"010300006"

#define kGetItemsRating @"010100100"
#define kGetItemsMobile @"010100505"

#define KGetPlaylistBroadcastMobile @"010100517"

#define KGetBusinessDetails @"010100020"

#define KGetFavoriteCategoryByUser @"010100091"

#define KGetFavoriteMerchants @"010100303"

/// GetItemDetil Keys



#define KGetItemDetailMobile @"010100008"

#define KAddProductWatchedByUserKey @"030400471"

#define KGetRelatedItemsKey @"010100019"

#define KAddFavoriteItemMobileKey @"030400218"

#define KRemoveFavoriteItemMobileKey @"040400219"

#define KSearchFavoriteItemsByTypeKey @"010400221"

//http://api.meetup.com/2/groups?lat=51.509980&lon=-0.133700&page=20&key=1f5718c16a7fb3a5452f45193232

//Keys

#endif /* Constants_h */
