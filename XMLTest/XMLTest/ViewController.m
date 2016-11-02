//
//  ViewController.m
//  XMLTest
//
//  Created by ffm on 16/9/17.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "ViewController.h"
#import "Question.h"

@interface ViewController () <NSXMLParserDelegate, UIAlertViewDelegate>
{
    int index;
}
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *optionlabelA;
@property (weak, nonatomic) IBOutlet UILabel *optionLabelB;
@property (weak, nonatomic) IBOutlet UILabel *optionLabelC;
@property (weak, nonatomic) IBOutlet UILabel *optionLabelD;
@property (weak, nonatomic) IBOutlet UIButton *previousBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (nonatomic, strong) NSMutableArray *questionMutArr;
@property (nonatomic, strong) Question *currentQuestion;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"XMLTestSingleChoice" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:strPath];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self;
    [parser parse];
}


#pragma mark - clickMethods

- (IBAction)clickPresviousBtn:(id)sender {
    if (index>0)
    {
        index--;
        [self refreshQuestion:index];
        self.nextBtn.enabled = YES;
    } else
    {
        self.previousBtn.enabled = NO;
    }
}
- (IBAction)clickNextBtn:(id)sender {
    if (index<2)
    {
        index++;
        [self refreshQuestion:index];
        self.previousBtn.enabled = YES;
    } else
    {
        self.nextBtn.enabled = NO;
    }
}

- (IBAction)clickCommitBtn:(id)sender {
//    if ([self.answerTextField.text isEqualToString:self.currentQuestion.rightAnswer])
//    {
//        NSLog(@"正确");
//    } else
//    {
//        NSLog(@"错误");
//    }

    if ([self.answerTextField.text isEqualToString:self.currentQuestion.rightAnswer])
    {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"正确" message:@"恭喜你答对了!" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [view show];
//        [view dismissWithClickedButtonIndex:0 animated:YES];

    } else
    {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"错误" message:@"很遗憾你答错了!" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil];
        [view show];
//        [view dismissWithClickedButtonIndex:0 animated:YES];

    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    NSLog(@"取消button!");
}

- (void)alertViewCancel:(UIAlertView *)alertView NS_DEPRECATED_IOS(2_0, 9_0)
{
    NSLog(@"取消!");
}

- (void)refreshQuestion:(int )indexNum
{
    self.currentQuestion = self.questionMutArr[indexNum];
    self.questionLabel.text = self.currentQuestion.questionText;
    self.optionlabelA.text = self.currentQuestion.optionA;
    self.optionLabelB.text = self.currentQuestion.optionB;
    self.optionLabelC.text = self.currentQuestion.optionC;
    self.optionLabelD.text = self.currentQuestion.optionD;
}

#pragma mark - NSXMLParserDelegate
//开始检索的时候
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"开始啦\n");
}

//结束检索的时候
- (void)parserDidEndDocument:(NSXMLParser *)parser;
{
    index = 0;
    [self refreshQuestion:index];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if ([elementName isEqualToString:@"question"])
    {
        self.currentQuestion = [[Question alloc] init];
        [self.questionMutArr addObject:self.currentQuestion];
        self.currentQuestion.questionText = attributeDict[@"text"];
        self.currentQuestion.rightAnswer = attributeDict[@"right"];
    } else if ([elementName isEqualToString:@"answer"])
    {
        NSString *tag = attributeDict[@"tag"];
        if ([tag isEqualToString:@"A"])
        {
            self.currentQuestion.optionA = attributeDict[@"text"];
        } else if ([tag isEqualToString:@"B"])
        {
            self.currentQuestion.optionB = attributeDict[@"text"];
        } else if ([tag isEqualToString:@"C"])
        {
            self.currentQuestion.optionC = attributeDict[@"text"];
        } else if ([tag isEqualToString:@"D"])
        {
            self.currentQuestion.optionD = attributeDict[@"text"];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{

    
}


#pragma mark - 懒加载
- (NSMutableArray *)questionMutArr
{
    if (!_questionMutArr)
    {
        _questionMutArr = [NSMutableArray array];
    }
    return _questionMutArr;
}


@end
