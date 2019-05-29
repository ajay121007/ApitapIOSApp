//
//  PaymentVC.m
//  ApiTap
//
//  Created by Bikramjeet Singh on 11/11/16.
//  Copyright © 2016 ApiTap. All rights reserved.
//

#import "PaymentVC.h"
#import "NSData+Base64.h"
#import "AFNetworking.h"

@interface PaymentVC () <NSURLSessionDelegate,NSURLConnectionDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txt_UserName;

@property (weak, nonatomic) IBOutlet UITextField *txt_AccountNumber;

@property (weak, nonatomic) IBOutlet UITextField *txt_ExpDate;

@property (weak, nonatomic) IBOutlet UITextField *txt_EnterCVC;


@end

@implementation PaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationItem.title=@"Payment";
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    self.navigationItem.title=@"";
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 2) {
        
        __block NSString *text = [textField text];
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        
        if (newString.length >= 20) {
            return NO;
        }
        
        [textField setText:newString];
        
        return NO;
        
    }else if (textField.tag == 4){
        
        __block NSString *text = [textField text];
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        
        if (newString.length >= 4) {
            return NO;
        }
        
        [textField setText:newString];
        
        return NO;
        
    }else if (textField.tag == 3) {
       
        __block NSString *text = [textField text];
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 2)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 2) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 2)];
        }
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        
        if (newString.length >= 6) {
            return NO;
        }
        
        [textField setText:newString];
        
        return NO;
        
        
    }else{
        
        return YES;
    }
    
  
}

- (IBAction)btn_SubmitAction:(id)sender {
    
    [self getRelatedItems];
}

-(void)getRelatedItems{
    
    if (![self checkInternetConeection]) {
        
        return;
    }
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    
    [dictParam setValue:@"2274" forKey:@"addressId"];
    [dictParam setValue:@"5454545454545454" forKey:@"cardNumber"];
    [dictParam setValue:@"61" forKey:@"cardType"];
    [dictParam setValue:@"123" forKey:@"cvv"];
    [dictParam setValue:@"12" forKey:@"expireMonth"];
    [dictParam setValue:@"2016" forKey:@"expireYear"];
    [dictParam setValue:@"Bikram" forKey:@"firstName"];
    [dictParam setValue:@"jeet" forKey:@"lastName"];
    [dictParam setValue:@"vicky" forKey:@"nickname"];
   
    
    NSString *str=[[NSUserDefaults standardUserDefaults]valueForKey:@"loginUserID"];
    
    NSString *code = [str substringFromIndex: [str length] - 11];
    
    // Skip leading zeros
    NSScanner *scanner = [NSScanner scannerWithString:code];
    NSCharacterSet *zeros = [NSCharacterSet
                             characterSetWithCharactersInString:@"0"];
    [scanner scanCharactersFromSet:zeros intoString:NULL];
    
    // Get the rest of the string and log it
    NSString *result = [code substringFromIndex:[scanner scanLocation]];
    
     [dictParam setValue:result forKey:@"nmcId"];
    
   
    [self asynchronousRequestWithPath:@"" requestType:1 params:dictParam timeOut:200 includeHeaders:YES onCompletion:^(long statusCode, NSDictionary *json,NSError *err)
     {
         NSLog(@"%@",json);
        
     } ];
    
}

-(void)asynchronousRequestWithPath:(NSString *)strPath
                       requestType:(RequestType)type
                            params:(NSDictionary *)dictParams
                           timeOut:(NSInteger)timeOut
                    includeHeaders:(BOOL)include
                      onCompletion:(JSONResponseBlock)completionBlock
{
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictParams options:NSJSONReadingMutableContainers error:&error];
    NSString *jsonString=nil;
    
    if (! jsonData){
        NSLog(@"Got an error: %@", error);
    }
    else{
        
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",jsonString);
    }
    
    NSData *plainTextData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainTextData base64EncodedString];
   // NSData   *resultdata = [base64String dataUsingEncoding:NSUTF8StringEncoding];
 
    base64String = [base64String stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *strURL =@"https://209.46.35.217:4143/ApiService/CreateToken/";
    
    strURL= [strURL stringByAppendingString:base64String];   // NSLog(@"%@",strURL)
    
    NSLog(@"%@",strURL);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:strURL]]; // Upload a file on disk
   

    switch (type)
    {
        case 0:
            
            [request setRequestMethod:@"POST"];
            break;
        case 1:
            [request setRequestMethod:@"GET"];
            break;
        case 2:
            [request setRequestMethod:@"DELETE"];
            break;
        case 3:
            [request setRequestMethod:@"PUT"];
            break;
    }
  
    if (include)
    {
        [request addRequestHeader:@"Content-Type" value:@"text/html; charset=UTF-8"];
    }
   // [request setValidatesSecureCertificate:NO];
    [request addRequestHeader:@"Accept" value:@"text/html; charset=UTF-8"];
    [request setDelegate:self];
    

    // Now, let's grab the certificate (included in the resources of the test app)
    SecIdentityRef identity = NULL;
    SecTrustRef trust = NULL;
    NSData *PKCS12Data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"]];
    [PaymentVC extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data];
    
        // In this case, we have no need to add extra certificates, just the one inside the indentity will be used
    [request setClientCertificateIdentity:identity];
    [request setValidatesSecureCertificate:NO];
  
    
    // Make sure the request got the correct content
        [request setTimeOutSeconds:timeOut];  //30
    [request startAsynchronous];
    
    
    __weak typeof(request) weakrequest = request;
    
    [request setCompletionBlock:^{
        
        NSError *error = nil;
        
        //NSDictionary  *dictResponse = [NSJSONSerialization JSONObjectWithData:[weakrequest.responseString dataUsingEncoding:NSUTF8StringEncoding] options:0 error: &error];
        
        id json = [NSJSONSerialization JSONObjectWithData:[weakrequest.responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        
       
        
        NSString *decodedString = [[NSString alloc] initWithData:weakrequest.responseData encoding:NSUTF8StringEncoding];
         NSLog(@"%@",decodedString);
        if(error)
            NSLog(@"Error in response : %@",error);
        
        completionBlock(weakrequest.responseStatusCode, json, nil);
    }];
    
    
    [request setFailedBlock:^{
        
        completionBlock(weakrequest.responseStatusCode, nil, weakrequest.error);
         NSLog(@"Error in response : %@",weakrequest.error);
        
    }];
    
}

+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef*)outTrust fromPKCS12Data:(NSData *)inPKCS12Data
{
    OSStatus securityError = errSecSuccess;
    
    NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObject:@"" forKey:(id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((CFDataRef)inPKCS12Data,(CFDictionaryRef)optionsDictionary,&items);
    
    if (securityError == 0) {
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void *tempTrust = NULL;
        tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failed with error code %d",(int)securityError);
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


