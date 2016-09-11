# read data
library("lubridate")
library("ggplot2")
library("reshape")
library('scales')

d = read.table('./data/gf.txt',sep=',',header = TRUE,encoding='UTF-8',stringsAsFactors=FALSE)

# d$up = parse_date_time(paste(d$date,d$up),orders='ymd hm')
# d$work = parse_date_time(paste(d$date,d$work),orders='ymd hm')
# d$down = parse_date_time(paste(d$date,d$down),orders='ymd hm')
# d$date = parse_date_time(d$date,orders='ymd')
#
#
# dd  = as.numeric(d$work - trunc(d$work,'days'))
# class(dd) <- "POSIXct"
# qplot(dd) + scale_x_datetime(labels = date_format("%S:00"))


d$up = parse_date_time(d$up,orders='hm')
d$work = parse_date_time(d$work,orders='hm')
d$down = parse_date_time(d$down,orders='hm')
d$date = parse_date_time(d$date,orders='ymd')

start_date = '2016-08-29 00:00'
end_date = '2016-09-04 24:00'
flag1 = d$date >= start_date
flag2 = d$date <=  end_date
d = subset(d, flag1 & flag2  )

d['week'] = 1:7

# 画图
d$down[7] = d$down[7] - days(1)
d

d_r = melt(d,id=c('date','week'))


p = ggplot(d_r,aes(week,value)) + geom_point(size=3) + geom_line() + facet_grid(variable~.,scales = "free")
p + scale_y_datetime(date_labels='%H:%M',date_breaks="30 min",  date_minor_breaks="15 min")


# 基本统计量


ggplot(d,aes(week,up)) + geom_point() + geom_line()

qplot(week,up,data=d)



