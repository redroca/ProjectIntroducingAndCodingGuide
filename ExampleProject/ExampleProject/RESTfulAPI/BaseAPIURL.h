//
//  BaseAPIURL.h
//  AlsTravel
//
//  Created by Benjamin on 3/2/17.
//  Copyright © 2017 Cloud4Magic. All rights reserved.
//

#define PRODUCTION_RELEASE

#import "CommonAppHeaders.h"

//LOCAL
#ifdef LOCAL_DEVELOPMENT
#define RESTFUL_BASE_HOST           @"http://192.168.8.169:3000/api/v1"
#define RESTFUL_SUFFIX_TOKEN        [NSString stringWithFormat:@"?access_token=%@", [CoreStore sharedStore].patrolAccessToken]

//TEST
#elif defined TEST_DEVELOPMENT
#define RESTFUL_BASE_HOST           @"https://api.xunbaox.com/api/v1"
#define RESTFUL_SUFFIX_TOKEN        [NSString stringWithFormat:@"?access_token=%@", [CoreStore sharedStore].patrolAccessToken]

//PRODUCTION
#elif defined PRODUCTION_RELEASE
#define RESTFUL_BASE_HOST           @"https://api.xunbaox.com/api/v1"
#define RESTFUL_SUFFIX_TOKEN        [NSString stringWithFormat:@"?access_token=%@", [CoreStore sharedStore].patrolAccessToken]

#endif



///////////////////----------- Example -----------///////////////////
#define URL_EXAMPLECONTENT                    [NSString stringWithFormat:@"%@/example%@", RESTFUL_BASE_HOST, URLExtension]
#define URL_SEARCHPRODUCTS(k,i,s,o,N)         [NSString stringWithFormat:@"%@/search%@?keyword=%@&page=%@&pagesize=%@&sort=%@&N=%@", RESTFUL_BASE_HOST, URLExtension,k,i,s,o,N]
#define URL_GET_MY_PRODUCTS                   @"/gto/products/my"
#define URL_GET_PRODUCT_DETAIL(productId)     [NSString stringWithFormat:@"/gto/products/%@", productId]
/////////////////////////////--- End ---/////////////////////////////

#define CLIENT_ID       @"77b437330184b6e613d316b8f57c3b58ac762fc52d493fce1411ae919ca0288c"
#define CLIENT_SECRET   @"331931da468a50e02fe1b56bcbe3e78382b00a7931675fd237605d7e1d81d7cc"

