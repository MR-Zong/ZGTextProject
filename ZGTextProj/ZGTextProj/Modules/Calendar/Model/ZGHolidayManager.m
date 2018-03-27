//
//  ZGHolidayManager.m
//  ZGTextProj
//
//  Created by 徐宗根 on 2017/9/10.
//  Copyright © 2017年 XuZonggen. All rights reserved.
//

#import "ZGHolidayManager.h"
#import "ZGCalendarManager.h"

const int START_YEAR =1901;
const int END_YEAR =2050;
static int32_t gLunarHolDay[]=
{
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1901
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1902
    0X96, 0XA5, 0X87, 0X96, 0X87, 0X87, 0X79, 0X69, 0X69, 0X69, 0X78, 0X78, //1903
    0X86, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X78, 0X87, //1904
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1905
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1906
    0X96, 0XA5, 0X87, 0X96, 0X87, 0X87, 0X79, 0X69, 0X69, 0X69, 0X78, 0X78, //1907
    0X86, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1908
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1909
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1910
    0X96, 0XA5, 0X87, 0X96, 0X87, 0X87, 0X79, 0X69, 0X69, 0X69, 0X78, 0X78, //1911
    0X86, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1912
    0X95, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1913
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1914
    0X96, 0XA5, 0X97, 0X96, 0X97, 0X87, 0X79, 0X79, 0X69, 0X69, 0X78, 0X78, //1915
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1916
    0X95, 0XB4, 0X96, 0XA6, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X87, //1917
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X77, //1918
    0X96, 0XA5, 0X97, 0X96, 0X97, 0X87, 0X79, 0X79, 0X69, 0X69, 0X78, 0X78, //1919
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1920
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X87, //1921
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X77, //1922
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X69, 0X69, 0X78, 0X78, //1923
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1924
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X87, //1925
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1926
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1927
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1928
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1929
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1930
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1931
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1932
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1933
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1934
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1935
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1936
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1937
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1938
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1939
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1940
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1941
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1942
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1943
    0X96, 0XA5, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1944
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1945
    0X95, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77, //1946
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1947
    0X96, 0XA5, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //1948
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X79, 0X78, 0X79, 0X77, 0X87, //1949
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77, //1950
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78, //1951
    0X96, 0XA5, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //1952
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1953
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X68, 0X78, 0X87, //1954
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1955
    0X96, 0XA5, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //1956
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1957
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1958
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1959
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1960
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1961
    0X96, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1962
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1963
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1964
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1965
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1966
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1967
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1968
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1969
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1970
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77, //1971
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1972
    0XA5, 0XB5, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1973
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1974
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77, //1975
    0X96, 0XA4, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X89, 0X88, 0X78, 0X87, 0X87, //1976
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //1977
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X78, 0X87, //1978
    0X96, 0XB4, 0X96, 0XA6, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77, //1979
    0X96, 0XA4, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1980
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X77, 0X87, //1981
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1982
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77, //1983
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87, //1984
    0XA5, 0XB4, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //1985
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1986
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X79, 0X78, 0X69, 0X78, 0X87, //1987
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //1988
    0XA5, 0XB4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1989
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //1990
    0X95, 0XB4, 0X96, 0XA5, 0X86, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1991
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //1992
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1993
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1994
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X76, 0X78, 0X69, 0X78, 0X87, //1995
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //1996
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //1997
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //1998
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //1999
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //2000
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2001
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //2002
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //2003
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //2004
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2005
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2006
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87, //2007
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86, //2008
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2009
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2010
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X78, 0X87, //2011
    0X96, 0XB4, 0XA5, 0XB5, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86, //2012
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87, //2013
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2014
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //2015
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86, //2016
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87, //2017
    0XA5, 0XB4, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2018
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //2019
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X86, //2020
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //2021
    0XA5, 0XB4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2022
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87, //2023
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96, //2024
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //2025
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2026
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //2027
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96, //2028
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //2029
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2030
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87, //2031
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96, //2032
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X86, //2033
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X78, 0X88, 0X78, 0X87, 0X87, //2034
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2035
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96, //2036
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86, //2037
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2038
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2039
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96, //2040
    0XA5, 0XC3, 0XA5, 0XB5, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86, //2041
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87, //2042
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2043
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X88, 0X87, 0X96, //2044
    0XA5, 0XC3, 0XA5, 0XB4, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86, //2045
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87, //2046
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87, //2047
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA5, 0X97, 0X87, 0X87, 0X88, 0X86, 0X96, //2048
    0XA4, 0XC3, 0XA5, 0XA5, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X86, //2049
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X78, 0X78, 0X87, 0X87 //2050
};

@interface ZGHolidayManager ()

@property (nonatomic, strong) NSDictionary *lunarHolidayDict;
@property (nonatomic, strong) NSMutableDictionary *gregorianHolidayDict;
@property (nonatomic, strong) NSArray *lunarSpecialDays;

@end

@implementation ZGHolidayManager


+ (instancetype)shareHolidayManager
{
    static dispatch_once_t onceToken;
    static ZGHolidayManager *_holidayManager_ = nil;
    dispatch_once(&onceToken, ^{
        _holidayManager_ = [[ZGHolidayManager alloc] init];
        [_holidayManager_ initialize];
    });
    
    return _holidayManager_;
}


- (void)initialize
{
    // 农历节日
     _lunarHolidayDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"春节", @"1-1",
                                    @"元宵", @"1-15",
                                    @"端午", @"5-5",
                                    @"七夕", @"7-7",
                                    @"中元", @"7-15",
                                    @"中秋", @"8-15",
                                    @"重阳", @"9-9",
                                    @"腊八", @"12-8",
                                    @"小年", @"12-24",
                                    nil];

    _lunarSpecialDays = [NSArray arrayWithObjects:
                         @"小寒", @"大寒", @"立春", @"雨水", @"惊蛰", @"春分",
                         @"清明", @"谷雨", @"立夏", @"小满", @"芒种", @"夏至",
                         @"小暑", @"大暑", @"立秋", @"处暑", @"白露", @"秋分",
                         @"寒露", @"霜降", @"立冬", @"小雪", @"大雪", @"冬至", nil];
    
    
    // 公历节日
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setObject:@"元旦" forKey:@"0101"];
    [dict setObject:@"中国第13亿人口日" forKey:@"0106"];
    [dict setObject:@"周恩来逝世纪念日" forKey:@"0108"];
    [dict setObject:@"释迦如来成道日" forKey:@"0115"];
    [dict setObject:@"列宁逝世纪念日 国际声援南非日 弥勒佛诞辰" forKey:@"0121"];
    [dict setObject:@"世界湿地日" forKey:@"0202"];
    [dict setObject:@"二七大罢工纪念日" forKey:@"0207"];
    [dict setObject:@"国际气象节" forKey:@"0210"];
    [dict setObject:@"情人节" forKey:@"0214"];
    [dict setObject:@"中国12亿人口日" forKey:@"0215"];
    [dict setObject:@"邓小平逝世纪念日" forKey:@"0219"];
    [dict setObject:@"国际母语日 反对殖民制度斗争日" forKey:@"0221"];
    [dict setObject:@"苗族芦笙节" forKey:@"0222"];
    [dict setObject:@"第三世界青年日" forKey:@"0224"];
    [dict setObject:@"世界居住条件调查日" forKey:@"0228"];
    [dict setObject:@"国际海豹日" forKey:@"0301"];
    [dict setObject:@"全国爱耳日" forKey:@"0303"];
    [dict setObject:@"学雷锋纪念日 中国青年志愿者服务日" forKey:@"0305"];
    [dict setObject:@"妇女节" forKey:@"0308"];
    [dict setObject:@"保护母亲河日" forKey:@"0309"];
    [dict setObject:@"国际尊严尊敬日" forKey:@"0311"];
    [dict setObject:@"国际警察日 白色情人节" forKey:@"0314"];
    [dict setObject:@"消费者权益日" forKey:@"0315"];
    [dict setObject:@"手拉手情系贫困小伙伴全国统一行动日" forKey:@"0316"];
    [dict setObject:@"中国国医节 国际航海日 爱尔兰圣帕特里克节" forKey:@"0317"];
    [dict setObject:@"全国科技人才活动日" forKey:@"0318"];
    [dict setObject:@"世界森林日 消除种族歧视国际日 世界儿歌日 世界睡眠日" forKey:@"0321"];
    [dict setObject:@"世界水日" forKey:@"0322"];
    [dict setObject:@"世界气象日" forKey:@"0323"];
    [dict setObject:@"世界防治结核病日" forKey:@"0324"];
    [dict setObject:@"全国中小学生安全教育日" forKey:@"0325"];
    [dict setObject:@"中国黄花岗七十二烈士殉难纪念" forKey:@"0329"];
    [dict setObject:@"巴勒斯坦国土日" forKey:@"0330"];
    [dict setObject:@"愚人节 全国爱国卫生运动月 税收宣传月" forKey:@"0401"];
    [dict setObject:@"国际儿童图书日" forKey:@"0402"];
    [dict setObject:@"世界卫生日" forKey:@"0407"];
    [dict setObject:@"世界帕金森病日" forKey:@"0411"];
    [dict setObject:@"全国企业家活动日" forKey:@"0421"];
    [dict setObject:@"世界地球日 世界法律日" forKey:@"0422"];
    [dict setObject:@"世界图书和版权日" forKey:@"0423"];
    [dict setObject:@"亚非新闻工作者日 世界青年反对殖民主义日" forKey:@"0424"];
    [dict setObject:@"全国预防接种宣传日" forKey:@"0425"];
    [dict setObject:@"世界知识产权日" forKey:@"0426"];
    [dict setObject:@"世界交通安全反思日" forKey:@"0430"];
    [dict setObject:@"国际劳动节" forKey:@"0501"];
    [dict setObject:@"世界哮喘日 世界新闻自由日" forKey:@"0503"];
    [dict setObject:@"中国五四青年节 科技传播日" forKey:@"0504"];
    [dict setObject:@"碘缺乏病防治日 日本男孩节" forKey:@"0505"];
    [dict setObject:@"世界红十字日" forKey:@"0508"];
    [dict setObject:@"国际护士节" forKey:@"0512"];
    [dict setObject:@"国际家庭日" forKey:@"0515"];
    [dict setObject:@"国际电信日" forKey:@"0517"];
    [dict setObject:@"国际博物馆日" forKey:@"0518"];
    [dict setObject:@"全国学生营养日 全国母乳喂养宣传日" forKey:@"0520"];
    [dict setObject:@"国际牛奶日" forKey:@"0523"];
    [dict setObject:@"世界向人体条件挑战日" forKey:@"0526"];
    [dict setObject:@"中国“五卅”运动纪念日" forKey:@"0530"];
    [dict setObject:@"世界无烟日 英国银行休假日" forKey:@"0531"];
    [dict setObject:@"国际儿童节" forKey:@"0601"];
    [dict setObject:@"世界环境保护日" forKey:@"0605"];
    [dict setObject:@"世界献血者日" forKey:@"0614"];
    [dict setObject:@"防治荒漠化和干旱日" forKey:@"0617"];
    [dict setObject:@"世界难民日" forKey:@"0620"];
    [dict setObject:@"中国儿童慈善活动日" forKey:@"0622"];
    [dict setObject:@"国际奥林匹克日" forKey:@"0623"];
    [dict setObject:@"全国土地日" forKey:@"0625"];
    [dict setObject:@"国际禁毒日 国际宪章日 禁止药物滥用和非法贩运国际日 支援酷刑受害者国际日" forKey:@"0626"];
    [dict setObject:@"世界青年联欢节" forKey:@"0630"];
    [dict setObject:@"建党节 香港回归纪念日 中共诞辰 世界建筑日" forKey:@"0701"];
    [dict setObject:@"国际体育记者日" forKey:@"0702"];
    [dict setObject:@"朱德逝世纪念日" forKey:@"0706"];
    [dict setObject:@"抗日战争纪念日" forKey:@"0707"];
    [dict setObject:@"世界人口日 中国航海日" forKey:@"0711"];
    [dict setObject:@"世界语创立日" forKey:@"0726"];
    [dict setObject:@"第一次世界大战爆发" forKey:@"0728"];
    [dict setObject:@"非洲妇女日" forKey:@"0730"];
    [dict setObject:@"建军节" forKey:@"0801"];
    [dict setObject:@"恩格斯逝世纪念日" forKey:@"0805"];
    [dict setObject:@"国际电影节" forKey:@"0806"];
    [dict setObject:@"中国男子节" forKey:@"0808"];
    [dict setObject:@"国际青年节" forKey:@"0812"];
    [dict setObject:@"国际左撇子日" forKey:@"0813"];
    [dict setObject:@"抗日战争胜利纪念" forKey:@"0815"];
    [dict setObject:@"全国律师咨询日" forKey:@"0826"];
    [dict setObject:@"日本签署无条件投降书日" forKey:@"0902"];
    [dict setObject:@"中国抗日战争胜利纪念日" forKey:@"0903"];
    [dict setObject:@"瑞士萨永中世纪节" forKey:@"0905"];
    [dict setObject:@"帕瓦罗蒂去世" forKey:@"0906"];
    [dict setObject:@"国际扫盲日 国际新闻工作者日" forKey:@"0908"];
    [dict setObject:@"毛泽东逝世纪念日" forKey:@"0909"];
    //    [dict setObject:@"中国教师节 世界预防自杀日" forKey:@"0910"];
    [dict setObject:@"中国教师节" forKey:@"0910"];
    [dict setObject:@"世界清洁地球日" forKey:@"0914"];
    [dict setObject:@"国际臭氧层保护日 中国脑健康日" forKey:@"0916"];
    [dict setObject:@"九·一八事变纪念日" forKey:@"0918"];
    [dict setObject:@"国际爱牙日" forKey:@"0920"];
    [dict setObject:@"世界停火日 预防世界老年性痴呆宣传日" forKey:@"0921"];
    [dict setObject:@"世界旅游日" forKey:@"0927"];
    [dict setObject:@"孔子诞辰" forKey:@"0928"];
    [dict setObject:@"国际翻译日" forKey:@"0930"];
    [dict setObject:@"国庆节 世界音乐日 国际老人节" forKey:@"1001"];
    [dict setObject:@"国际和平与民主自由斗争日" forKey:@"1002"];
    [dict setObject:@"世界动物日" forKey:@"1004"];
    [dict setObject:@"国际教师节" forKey:@"1005"];
    [dict setObject:@"中国老年节" forKey:@"1006"];
    [dict setObject:@"全国高血压日 世界视觉日" forKey:@"1008"];
    [dict setObject:@"世界邮政日 万国邮联日" forKey:@"1009"];
    [dict setObject:@"辛亥革命纪念日 世界精神卫生日 世界居室卫生日" forKey:@"1010"];
    [dict setObject:@"世界保健日 国际教师节 中国少年先锋队诞辰日 世界保健日" forKey:@"1013"];
    [dict setObject:@"世界标准日" forKey:@"1014"];
    [dict setObject:@"国际盲人节(白手杖节)" forKey:@"1015"];
    [dict setObject:@"世界粮食日" forKey:@"1016"];
    [dict setObject:@"世界消除贫困日" forKey:@"1017"];
    [dict setObject:@"世界骨质疏松日" forKey:@"1020"];
    [dict setObject:@"世界传统医药日" forKey:@"1022"];
    [dict setObject:@"联合国日 世界发展新闻日" forKey:@"1024"];
    [dict setObject:@"中国男性健康日" forKey:@"1028"];
    [dict setObject:@"万圣节 世界勤俭日" forKey:@"1031"];
    [dict setObject:@"达摩祖师圣诞" forKey:@"1102"];
    [dict setObject:@"柴科夫斯基逝世悼念日" forKey:@"1106"];
    [dict setObject:@"十月社会主义革命纪念日" forKey:@"1107"];
    [dict setObject:@"中国记者日" forKey:@"1108"];
    [dict setObject:@"全国消防安全宣传教育日" forKey:@"1109"];
    [dict setObject:@"世界青年节" forKey:@"1110"];
    [dict setObject:@"光棍节 国际科学与和平周" forKey:@"1111"];
    [dict setObject:@"孙中山诞辰纪念日" forKey:@"1112"];
    [dict setObject:@"世界糖尿病日" forKey:@"1114"];
    [dict setObject:@"泰国大象节" forKey:@"1115"];
    [dict setObject:@"国际大学生节 世界学生节 世界戒烟日" forKey:@"1117"];
    [dict setObject:@"世界儿童日" forKey:@"1120"];
    [dict setObject:@"世界问候日 世界电视日" forKey:@"1121"];
    [dict setObject:@"国际声援巴勒斯坦人民国际日" forKey:@"1129"];
    [dict setObject:@"世界艾滋病日" forKey:@"1201"];
    [dict setObject:@"废除一切形式奴役世界日" forKey:@"1202"];
    [dict setObject:@"世界残疾人日" forKey:@"1203"];
    [dict setObject:@"全国法制宣传日" forKey:@"1204"];
    [dict setObject:@"国际经济和社会发展志愿人员日 世界弱能人士日" forKey:@"1205"];
    [dict setObject:@"国际民航日" forKey:@"1207"];
    [dict setObject:@"国际儿童电视日" forKey:@"1208"];
    [dict setObject:@"世界足球日 一二·九运动纪念日" forKey:@"1209"];
    [dict setObject:@"世界人权日" forKey:@"1210"];
    [dict setObject:@"世界防止哮喘日" forKey:@"1211"];
    [dict setObject:@"西安事变纪念日" forKey:@"1212"];
    [dict setObject:@"南京大屠杀纪念日" forKey:@"1213"];
    [dict setObject:@"国际儿童广播电视节" forKey:@"1214"];
    [dict setObject:@"世界强化免疫日" forKey:@"1215"];
    [dict setObject:@"澳门回归纪念" forKey:@"1220"];
    [dict setObject:@"国际篮球日" forKey:@"1221"];
    [dict setObject:@"平安夜" forKey:@"1224"];
    [dict setObject:@"圣诞节" forKey:@"1225"];
    [dict setObject:@"毛泽东诞辰纪念日 节礼日" forKey:@"1226"];
    [dict setObject:@"国际生物多样性日" forKey:@"1229"];
    
    _gregorianHolidayDict = dict;

}

- (void)retainData
{
    NSArray *LunarZodiac = [NSArray arrayWithObjects:@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪",nil];
    
    NSArray *SolarTerms = [NSArray arrayWithObjects:@"立春", @"雨水", @"惊蛰", @"春分", @"清明", @"谷雨", @"立夏", @"小满", @"芒种", @"夏至", @"小暑", @"大暑", @"立秋", @"处暑", @"白露", @"秋分", @"寒露", @"霜降", @"立冬", @"小雪", @"大雪", @"冬至", @"小寒", @"大寒", nil];
}

- (NSString *)getLunarSpecialDayWithDay:(int)iDay month:(int)iMonth year:(int)iYear
{
    
    int array_index = (iYear - START_YEAR)*12+iMonth -1 ;
    int64_t flag = gLunarHolDay[array_index];
    int64_t day;
    if(iDay <15)
        day= 15 - ((flag>>4)&0x0f);
    else
        day = ((flag)&0x0f)+15;
    int index = -1;
    if(iDay == day){
        index = (iMonth-1) *2 + (iDay>15? 1: 0);
    }
    if ( index >= 0 && index < [self.lunarSpecialDays count] ) {
        return [self.lunarSpecialDays objectAtIndex:index];
    } else {
        return nil;
    }
}


- (NSString *)getLunarHoliDayWithDay:(NSInteger)day month:(NSInteger)month date:(NSDate *)date;
{
    if (month == 12) {
        
        NSTimeInterval timeInterval_day = 60.f*60.f*24.f;
        NSDate *nextDay_date = [NSDate dateWithTimeInterval:timeInterval_day sinceDate:date];
        NSCalendar *localeCalendar = [[ZGCalendarManager shareCalendarManager] getCalendarWithCalendarIdentifier:NSCalendarIdentifierChinese];
        
        unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:nextDay_date];
        if ( 1 == localeComp.month && 1 == localeComp.day ) {
            return @"除夕";
        }
    }
    
    NSString *key_str = [NSString stringWithFormat:@"%zd-%zd",month,day];
    return [self.lunarHolidayDict objectForKey:key_str];
}


- (NSString *)getWorldHolidayWithDay:(NSInteger)day month:(NSInteger)month
{
    NSString *monthDay;
    if(month<10 && day<10)
    {
        monthDay=[NSString stringWithFormat:@"0%zd0%zd",month,day] ;
    }
    else if(month<10 && day>9)
    {
        monthDay=[NSString stringWithFormat:@"0%zd%zd",month,day] ;
    }
    else if(month>9 && day<10)
    {
        monthDay=[NSString stringWithFormat:@"%zd0%zd",month,day] ;
    }
    else
    {
        monthDay=[NSString stringWithFormat:@"%zd%zd",month,day] ;
    }
    
    
    return [self.gregorianHolidayDict objectForKey:monthDay];
}

@end
