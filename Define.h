//
//  Define.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-14.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#ifndef LoveMovie_Define_h
#define LoveMovie_Define_h


#import <CoreLocation/CoreLocation.h>

#define kScreenSize    [UIScreen mainScreen].bounds.size
#define kImageSize  CGSizeMake(kScreenSize.width*0.4375, kScreenSize.width*0.625)
#define kHomeImageViewHeight 1.253*kScreenSize.width-44
//1、搜索接口默认热词界面
//http://api.m.mtime.cn/Search/HotKeyWords.api
#define kSearchHotUrl @"http://api.m.mtime.cn/Search/HotKeyWords.api"
#define kZZLid 489
#define myRed [UIColor colorWithRed:178.0/255 green:34.0/255  blue:34.0/255 alpha:1.0f]
#define myPink [UIColor colorWithRed:64.0/255 green:224.0/255  blue:208.0/255 alpha:1.0f]
#define myGray [[UIColor lightGrayColor] colorWithAlphaComponent:0.2]
#define myLight [UIColor colorWithRed:220.0/255 green:220.0/255  blue:220.0/255 alpha:1.0f]
//2、首页
//a、中间广告广告 advlist
//b、今日热点 hotpoints
//c、热点电影 hotmovies
//d、电影商城 areaseconds
//http://api.m.mtime.cn/PageSubArea/GetFirstPageAdvAndNews.api
#define kHomePageUrl @"http://api.m.mtime.cn/PageSubArea/GetFirstPageAdvAndNews.api"

//头视图
//
//http://api.m.mtime.cn/PageSubArea/HotPlayMovies.api?locationId=489
#define kHomeHeaderUrl @"http://api.m.mtime.cn/PageSubArea/HotPlayMovies.api?locationId=%d"

//3、每日佳片下的图片
//http://img22.mtime.cn/get.ashx?uri=http://img31.mtime.cn/mg/2015/07/13/105656.76828569.jpg&width=640&height=240&quality=75&clipType=4
//
//4、正在热映按钮
//http://api.m.mtime.cn/Showtime/LocationMovies.api?locationId=489
#define kBuyHotMovie @"http://api.m.mtime.cn/Showtime/LocationMovies.api?locationId=%d"

//正在热映点击看票按钮，时间url

#define kHotTimeUrl @"http://api.m.mtime.cn/Showtime/LocationMovieShowtimeDates.api?locationId=%d&movieId=%d"

//正在热映当前日期的当前电影 的各种影院
//http://api.m.mtime.cn/Showtime/LocationMovieShowtimes.api?date=20150726&locationId=489&movieId=211794&needAllShowtimes=1
//接口分别为 当前日期 当前位置id 当前电影id
#define kHotTimeCinemas @"http://api.m.mtime.cn/Showtime/LocationMovieShowtimes.api?date=%@&locationId=%d&movieId=%d&needAllShowtimes=1"

//正在热映当前日期的当前电影 的影院详情 接口分别为 影院id 和 电影id
//http://api.m.mtime.cn/Showtime/ShowtimesByMovieCinema.api?cinemaId=3961&movieId=211794
#define  kHotTimeCinemaDetail @"http://api.m.mtime.cn/Showtime/ShowtimesByMovieCinema.api?cinemaId=%d&movieId=%d"


//即将上映
#define kBuyComingMovie @"http://api.m.mtime.cn/Movie/MovieComingNew.api?locationId=%d"
//全部影院

#define kAllCinemaUrl @"http://api.m.mtime.cn/OnlineLocationCinema/OnlineCinemasByCity.api?locationId=%d"
//@"http://cdn.m.mtime.cn/Service/callback.mi/showtime/basecitydata.api?locationId=%d"

#define kCinemaDetailUrl @"http://api.m.mtime.cn/Showtime/ShowTimesByCinemaMovieDate.api?cinemaId=%d&date=%@&movieId=%d"
#define kCinemaDetHeaderUrl @"http://api.m.mtime.cn/Showtime/ShowtimeMovieAndDateListByCinema.api?cinemaId=%d"

//位置 latitude 维度 longitude 经度
//http://api.m.mtime.cn/GetCityByLongitudelatitude.api?latitude=34.778438&longitude=113.682454

#define kLocationUrl @"http://api.m.mtime.cn/GetCityByLongitudelatitude.api?latitude=%f&longitude=%f"

//http://api.m.mtime.cn/showtime/OnlineSeatsByShowTimeID.api?dId=131970221

#define kSeatsUrl @"http://api.m.mtime.cn/showtime/OnlineSeatsByShowTimeID.api?dId=%@"



//*****************************图片名称宏定义*******************************
#define kSeatUnselected @"v10_seat_unselected"
#define kSeatCantSelected @"v10_seat_cannot_select"
#define kSeatSelected @"v10_seat_selected"

#ifndef __UpLine__
//变参宏
#define BBLog(...) NSLog(__VA_ARGS__)
#else
#define BBLog(...)
#endif

#endif
